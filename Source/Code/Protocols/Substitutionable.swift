//
//  Substitutionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum Substitution<Number: NumberExpressible> {

    case constant(Number)
    case algebraic(Atom)

    var isConstant: Bool { return asConstant != nil }
    var asConstant: Number? {
        switch self {
        case .constant(let number): return number
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
    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Substitution<NumberType> {
        return substitute(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func substitute(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, makeConstants: () -> ([ConstantStruct<NumberType>])) -> Substitution<NumberType> {
        let constantArray = makeConstants()
        guard !constantArray.containsDuplicates() else { fatalError("cannot contain duplicates") }
        return substitute(constants: Set(constantArray), modulus: modulus, modulusMode: modulusMode)
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
    case .constant(let number): return .constant(handleNumber(number).modIfNeeded(modulus, modulusMode: modulusMode))
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
        let value = manyHandleAllNumbers(parsed.compactMap { $0.asConstant })
        return .constant(value.modIfNeeded(modulus, modulusMode: modulusMode))
    } else {
        let (initialResult, combine) = manyHandleMixedReduce
        let atom = parsed.reduce(initialResult, combine)
        return .algebraic(atom)
    }

}
