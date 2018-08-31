//
//  PolynomialProtocol.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol PolynomialProtocol:
    Algebraic,
    AbsoluteConvertible,
    Negatable
    where
    TermType.NumberType == Self.NumberType
{
    associatedtype TermType: TermProtocol
    var constant: NumberType { get }
    var terms: [TermType] { get }

    init(terms: [TermType], sorting: TermSorting<NumberType>, constant: NumberType)
    init(term: TermType, constant: NumberType)
    init(constant: NumberType)
}

// MARK: - Typealias
public extension PolynomialProtocol {
    typealias ExponentiationType = TermType.ExponentiationType
}

// MARK: - Convenience Initializers
public extension PolynomialProtocol {

    init(polynomial: Self) {
        self.init(terms: polynomial.terms, constant: polynomial.constant)
    }

    init(terms: [TermType], sorting: TermSorting<NumberType> = TermSorting<NumberType>(), constant: NumberType = .zero) {
        self.init(terms: terms, sorting: sorting, constant: constant)
    }

    init(term: TermType, constant: NumberType = .zero) {
        self.init(terms: [term], constant: constant)
    }

    init(constant: NumberType) {
        self.init(terms: [], constant: constant)
    }

    init(exponentiation: ExponentiationType, constant: NumberType = .zero) {
        self.init(term: TermType(exponentiation: exponentiation), constant: constant)
    }

    init(variable: VariableStruct<NumberType>, constant: NumberType = .zero) {
        self.init(exponentiation: ExponentiationType(variable), constant: constant)
    }
}

// MARK: - Public Extensions
public extension PolynomialProtocol {
    var highestExponent: NumberType? {
        guard !terms.isEmpty else { return nil }
        return terms.sorting(betweenTerms: .descendingExponent)[0].highestExponent
    }
}

// MARK: - ExpressibleByArrayLiteral
extension PolynomialStruct: ExpressibleByArrayLiteral {
    public init(arrayLiteral terms: TermType...) {
        self.init(terms: terms)
    }
}
