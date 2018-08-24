//
//  PolynomialProtocol.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol PolynomialProtocol: Algebraic, Negatable where TermType.NumberType == Self.NumberType, TermType.VariableType == Self.VariableType { 
    associatedtype TermType: TermProtocol
    var constant: NumberType { get }
    var terms: [TermType] { get }

    init(terms: [TermType], sorting: TermSorting<NumberType>, constant: NumberType)
    init(term: TermType)
    init(constant: NumberType)
}

// MARK: - Typealias
public extension PolynomialProtocol {
    typealias ExponentiationType = TermType.ExponentiationType
}

// MARK: - Convenience Initializers
public extension PolynomialProtocol {
    init(terms: [TermType] = [], sorting: TermSorting<NumberType> = .default, constant: NumberType = .zero) {
        self.init(terms: terms, sorting: sorting, constant: constant)
    }
    init(term: TermType) {
        self.init(terms: [term], constant: NumberType.zero)
    }
    init(constant: NumberType) {
        self.init(terms: [], constant: constant)
    }

    init(exponentiation: ExponentiationType) {
        self.init(term: TermType(exponentiation: exponentiation))
    }

    init(exponentiation: ExponentiationType, constant: NumberType = .zero) {
        self.init(TermType(exponentiation: exponentiation), constant: constant)
    }

    init(variable: VariableType, constant: NumberType = .zero) {
        self.init(exponentiation: ExponentiationType(variable), constant: constant)
    }

    // delete either of these two, recently added the one directly below, having the label `term` during refactoring
    init(term: TermType, constant: NumberType = .zero) {
        self.init(terms: [term], constant: constant)
    }

    init(_ term: TermType, constant: NumberType = .zero) {
        self.init(terms: [term], constant: constant)
    }

    init(constant: Double) {
        self.init(constant: NumberType(constant))
    }

    init(constant: Int) {
        self.init(constant: NumberType(constant))
    }
}

public extension PolynomialProtocol where NumberType: FloatingPointNumberExpressible {

    init<F>(constant: F) where F: BinaryFloatingPoint {
        self.init(constant: NumberType(constant))
    }

    // delete either of these two, recently added the one directly below, having the label `term` during refactoring
    init(_ constant: NumberType) {
        self.init(terms: [], constant: constant)
    }
    init(constant: NumberType) {
        self.init(terms: [], constant: constant)
    }
}

public extension PolynomialProtocol where NumberType: IntegerNumberExpressible {
    init<I>(constant: I) where I: BinaryInteger {
        self.init(constant: NumberType(constant))
    }
}


// MARK: - Public Extensions
public extension PolynomialProtocol {

    func contains(variable: VariableType) -> Bool {
        for term in terms {
            guard term.contains(variable: variable) else { continue }
            return true
        }
        return false
    }

    var uniqueVariables: Set<VariableType> {
        return Set(terms.flatMap { Array($0.uniqueVariables) })
    }
}


// MARK: - ExpressibleByFloatLiteral
extension PolynomialStruct: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    public init(floatLiteral value: Float) {
        self.init(constant: NumberType(value))
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension PolynomialStruct: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Int) {
        self.init(constant: NumberType(value))
    }
}

// MARK: - ExpressibleByArrayLiteral
extension PolynomialStruct: ExpressibleByArrayLiteral {
    public init(arrayLiteral terms: TermType...) {
        self.init(terms: terms)
    }
}
