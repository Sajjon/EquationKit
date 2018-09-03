//
//  Substitutionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Substitutionable: NumberTypeSpecifying {

    var uniqueVariables: Set<VariableStruct<NumberType>> { get }

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>?) -> PolynomialType<NumberType>
}

public extension Substitutionable {
    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>? = nil) -> PolynomialType<NumberType> {
        return substitute(constants: constants, modulus: modulus)
    }

    func substitute(constants: [ConstantStruct<NumberType>], modulus: Modulus<NumberType>? = nil) -> PolynomialType<NumberType> {
        guard !constants.containsDuplicates() else { fatalError("cannot contain duplicates") }
        return substitute(constants: Set(constants), modulus: modulus)
    }

    func substitute(constants: ConstantStruct<NumberType>..., modulus: Modulus<NumberType>? = nil) -> PolynomialType<NumberType> {
        return substitute(constants: constants, modulus: modulus)
    }

    func substitute(modulus: Modulus<NumberType>? = nil, makeConstants: () -> ([ConstantStruct<NumberType>])) -> PolynomialType<NumberType> {
        return substitute(constants: makeConstants(), modulus: modulus)
    }

    func substitute(modulus: Modulus<NumberType>? = nil, makeConstants: () -> ConstantStruct<NumberType>) -> PolynomialType<NumberType> {
        return substitute(constants: [makeConstants()], modulus: modulus)
    }

    // Constants passed as Dictionary<Variable, Number>
    func substitute(constants: [VariableStruct<NumberType>: NumberType], modulus: Modulus<NumberType>? = nil) -> PolynomialType<NumberType> {
        return substitute(constants: Set(constants.map { ConstantStruct<NumberType>($0, value: $1) }), modulus: modulus)
    }

    // Constants passed as Array<(Variable, Number)>
    func substitute(modulus: Modulus<NumberType>? = nil, makeConstants: () -> [(VariableStruct<NumberType>, NumberType)]) -> PolynomialType<NumberType> {
        let array = makeConstants().map { ConstantStruct<NumberType>($0, value: $1) }
        return substitute(constants: array, modulus: modulus)
    }

}

internal func parse<S, N>(
    substitutionable: S,
    constants: Set<ConstantStruct<N>>,
    modulus: Modulus<N>? = nil,
    handleNumber: ((N) -> N) = { $0 },
    handleAlgebraic: ((PolynomialType<N>) -> PolynomialType<N>)
    ) -> PolynomialType<N> where S: Substitutionable, N == S.NumberType {

    let polynomial = substitutionable.substitute(constants: constants, modulus: modulus)
    guard let constant = polynomial.asNumber else { return handleAlgebraic(polynomial) }

    return PolynomialType<N>(constant: handleNumber(constant).modIfNeeded(modulus))
}

internal func parseMany<S, N>(
    substitutionables: [S],
    constants: Set<ConstantStruct<N>>,
    modulus: Modulus<N>? = nil,
    manyHandleAllNumbers: (([N]) -> N),
    manyHandleMixedReduce: (initialResult: PolynomialType<N>, combine: ((PolynomialType<N>, PolynomialType<N>) -> PolynomialType<N>))
    ) -> PolynomialType<N> where S: Substitutionable, N == S.NumberType {

    let polynomials = substitutionables.map { $0.substitute(constants: constants, modulus: modulus) }


    if polynomials.allSatisfy({ $0.isNumber }) {
        let value = manyHandleAllNumbers(polynomials.compactMap { $0.asNumber })
        return PolynomialType<N>(constant: value.modIfNeeded(modulus))
    } else {
        let (initialResult, combine) = manyHandleMixedReduce
        return polynomials.reduce(initialResult, combine)
    }

}
