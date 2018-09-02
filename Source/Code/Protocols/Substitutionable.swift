//
//  Substitutionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Atom {
    func asConstant<N>() -> N? where N: NumberExpressible {
        if let number = self as? N {
            return number
        } else if let poly = self as? PolynomialType<N> {
            return poly.asConstant
        }
        return nil
    }
}

public enum Substitution<Number: NumberExpressible>: NumberTypeSpecifying {
    public typealias NumberType = Number

    case constant(Number)
    case algebraic(Atom)

    var isConstant: Bool { return asConstant != nil }
    var asConstant: Number? {
        switch self {
        case .constant(let number): return number
        case .algebraic(let atom): return atom.asConstant()
        }
    }
    var isAlgebraic: Bool { return asAlgebraic != nil }
    var asAlgebraic: Atom? {
        switch self {
        case .algebraic(let atom): return atom
        default: return nil
        }
    }

    var asAtom: Atom {
        switch self {
        case .algebraic(let algebraicAtom): return algebraicAtom
        case .constant(let number): return PolynomialType<Number>(constant: number) as Atom
        }
    }
}

public protocol Substitutionable: NumberTypeSpecifying {
    var uniqueVariables: Set<VariableStruct<NumberType>> { get }
    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Substitution<NumberType>
}

public extension Substitutionable {
    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType? = nil) -> Substitution<NumberType> {
        return substitute(constants: constants, modulus: modulus, modulusMode: .alwaysPositive)
    }
}

internal func parse<S, N>(
    substitutionable: S,
    constants: Set<ConstantStruct<N>>,
    modulus: N?,
    modulusMode: ModulusMode,
    handleNumber: ((N) -> N) = { $0 },
    handleAlgebraic: ((Atom) -> PolynomialType<N>)
    ) -> Substitution<N> where S: Substitutionable, N == S.NumberType {

    switch substitutionable.substitute(constants: constants, modulus: modulus, modulusMode: modulusMode) {
    case .constant(let number):
        var value = handleNumber(number)
        if let modulus = modulus {
            value = value.mod(modulus, modulusMode: modulusMode)
        }
        return .constant(value)
    case .algebraic(let algebraicAtom): return .algebraic(handleAlgebraic(algebraicAtom) as Atom)
    }
}

internal func parseMany<S, N>(
    substitutionables: [S],
    constants: Set<ConstantStruct<N>>,
    modulus: N?,
    modulusMode: ModulusMode,
    manyHandleAllNumbers: (([N]) -> N),
    manyHandleMixedReduce: (initialResult: Atom, combine: ((Atom, Substitution<N>) -> Atom))
    ) -> Substitution<N> where S: Substitutionable, N == S.NumberType {

    let parsed = substitutionables.map { $0.substitute(constants: constants, modulus: modulus, modulusMode: modulusMode) }

    if parsed.allSatisfy({ $0.isConstant }) {
        let constants = parsed.compactMap { $0.asConstant }
        var value = manyHandleAllNumbers(constants)
        if let modulus = modulus {
            value = value.mod(modulus, modulusMode: modulusMode)
        }
        return .constant(value)
    } else {
        let (initialResult, combine) = manyHandleMixedReduce
        let atom = parsed.reduce(initialResult, combine)
        return .algebraic(atom)
    }

}
