//
//  Substitutionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Substitution<Number: NumberExpressible>: Hashable {
    public let from: PolynomialType<Number>
    public let to: PolynomialType<Number>
    public init(from: PolynomialType<Number>, to: PolynomialType<Number>) {
        self.from = from
        self.to = to
    }
}
public extension Substitution {
    public init(fromVariable variable: VariableStruct<Number>, to number: Number) {
        self.init(
            from: PolynomialType<Number>(variable: variable),
            to: PolynomialType<Number>(constant: number)
        )
    }
}



public extension Substitution {
    var asConstant: ConstantStruct<Number>? {
        guard
            let variable = from.asVariable,
            let constantValue = to.asNumber
            else { return nil }
        return ConstantStruct<Number>(variable, value: constantValue)
    }
}

public protocol Substitutionable: NumberTypeSpecifying {

    var uniqueVariables: Set<VariableStruct<NumberType>> { get }

    func substitute(with substitutions: Set<Substitution<NumberType>>, modulus: Modulus<NumberType>?) -> PolynomialType<NumberType>
}

public extension Substitutionable {
    func substitute(with substitutions: Set<Substitution<NumberType>>, modulus: Modulus<NumberType>? = nil) -> PolynomialType<NumberType> {
        return substitute(with: substitutions, modulus: modulus)
    }

    func substitute(with substitutions: [Substitution<NumberType>], modulus: Modulus<NumberType>? = nil) -> PolynomialType<NumberType> {
        guard !substitutions.containsDuplicates() else { fatalError("cannot contain duplicates") }
        return substitute(with: Set(substitutions), modulus: modulus)
    }

    func substitute(with substitutions: Substitution<NumberType>..., modulus: Modulus<NumberType>? = nil) -> PolynomialType<NumberType> {
        return substitute(with: substitutions, modulus: modulus)
    }

    func substitute(modulus: Modulus<NumberType>? = nil, makeSubstitutions: () -> ([Substitution<NumberType>])) -> PolynomialType<NumberType> {
        return substitute(with: makeSubstitutions(), modulus: modulus)
    }

    func substitute(modulus: Modulus<NumberType>? = nil, makeSubstitutions: () -> Substitution<NumberType>) -> PolynomialType<NumberType> {
        return substitute(with: [makeSubstitutions()], modulus: modulus)
    }
}

internal func parse<S, N>(
    substitutionable: S,
    substitutions: Set<Substitution<N>>,
    modulus: Modulus<N>? = nil,
    handleNumber: ((N) -> N) = { $0 },
    handleAlgebraic: ((PolynomialType<N>) -> PolynomialType<N>)
    ) -> PolynomialType<N> where S: Substitutionable, N == S.NumberType {

    let polynomial = substitutionable.substitute(with: substitutions, modulus: modulus)
    guard let constant = polynomial.asNumber else { return handleAlgebraic(polynomial) }

    return PolynomialType<N>(constant: handleNumber(constant).modIfNeeded(modulus))
}

internal func parseMany<S, N>(
    substitutionables: [S],
    substitutions: Set<Substitution<N>>,
    modulus: Modulus<N>? = nil,
    manyHandleAllNumbers: (([N]) -> N),
    manyHandleMixedReduce: (initialResult: PolynomialType<N>, combine: ((PolynomialType<N>, PolynomialType<N>) -> PolynomialType<N>))
    ) -> PolynomialType<N> where S: Substitutionable, N == S.NumberType {

    let polynomials = substitutionables.map { $0.substitute(with: substitutions, modulus: modulus) }


    if polynomials.allSatisfy({ $0.isNumber }) {
        let value = manyHandleAllNumbers(polynomials.compactMap { $0.asNumber })
        return PolynomialType<N>(constant: value.modIfNeeded(modulus))
    } else {
        let (initialResult, combine) = manyHandleMixedReduce
        return polynomials.reduce(initialResult, combine)
    }

}
