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

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>?) -> Substitution<NumberType>
}

public extension Substitutionable {
    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>? = nil) -> Substitution<NumberType> {
        return substitute(constants: constants, modulus: modulus)
    }

    func substitute(constants: [ConstantStruct<NumberType>], modulus: Modulus<NumberType>? = nil) -> Substitution<NumberType> {
        guard !constants.containsDuplicates() else { fatalError("cannot contain duplicates") }
        return substitute(constants: Set(constants), modulus: modulus)
    }

    func substitute(constants: ConstantStruct<NumberType>..., modulus: Modulus<NumberType>? = nil) -> Substitution<NumberType> {
        return substitute(constants: constants, modulus: modulus)
    }

    func substitute(modulus: Modulus<NumberType>? = nil, makeConstants: () -> ([ConstantStruct<NumberType>])) -> Substitution<NumberType> {
        return substitute(constants: makeConstants(), modulus: modulus)
    }

    func substitute(modulus: Modulus<NumberType>? = nil, makeConstants: () -> ConstantStruct<NumberType>) -> Substitution<NumberType> {
        return substitute(constants: [makeConstants()], modulus: modulus)
    }

    // Constants passed as Dictionary<Variable, Number>
    func substitute(constants: [VariableStruct<NumberType>: NumberType], modulus: Modulus<NumberType>? = nil) -> Substitution<NumberType> {
        return substitute(constants: Set(constants.map { ConstantStruct<NumberType>($0, value: $1) }), modulus: modulus)
    }

    // Constants passed as Array<(Variable, Number)>
    func substitute(modulus: Modulus<NumberType>? = nil, makeConstants: () -> [(VariableStruct<NumberType>, NumberType)]) -> Substitution<NumberType> {
        let array = makeConstants().map { ConstantStruct<NumberType>($0, value: $1) }
        return substitute(constants: array, modulus: modulus)
    }

}



internal func parse<S, N>(
    substitutionable: S,
    constants: Set<ConstantStruct<N>>,
    modulus: Modulus<N>? = nil,
    handleNumber: ((N) -> N) = { $0 },
    handleAlgebraic: ((Atom) -> PolynomialType<N>)
    ) -> Substitution<N> where S: Substitutionable, N == S.NumberType {

    switch substitutionable.substitute(constants: constants, modulus: modulus) {
    case .constant(let number): return .constant(handleNumber(number).modIfNeeded(modulus))
    case .algebraic(let algebraicAtom): return .algebraic(handleAlgebraic(algebraicAtom) as Atom)
    }
}

internal func parseMany<S, N>(
    substitutionables: [S],
    constants: Set<ConstantStruct<N>>,
    modulus: Modulus<N>? = nil,
    manyHandleAllNumbers: (([N]) -> N),
    manyHandleMixedReduce: (initialResult: Atom, combine: ((Atom, Atom) -> Atom))
    ) -> Substitution<N> where S: Substitutionable, N == S.NumberType {

    let parsed = substitutionables.map { $0.substitute(constants: constants, modulus: modulus) }

    if parsed.allSatisfy({ $0.isConstant }) {
        let value = manyHandleAllNumbers(parsed.compactMap { $0.asConstant })
        return .constant(value.modIfNeeded(modulus))
    } else {
        let (initialResult, combine) = manyHandleMixedReduce
        let atom = parsed.map { $0.asAtom }.reduce(initialResult, combine)
        return .algebraic(atom)
    }

}
