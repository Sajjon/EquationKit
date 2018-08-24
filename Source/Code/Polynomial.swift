//
//  Polynomial.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
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
public extension PolynomialProtocol {
    typealias ExponentiationType = TermType.ExponentiationType
}




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
        fatalError()
    }
}
public typealias Polynomial = PolynomialStruct<Double>
public struct PolynomialStruct<Number: NumberExpressible>: PolynomialProtocol {

    public typealias NumberType = Number
    public typealias TermType = TermStruct<Number>
    public typealias VariableType = VariableStruct<NumberType>
    public let constant: NumberType
    public let terms: [TermType]


    public init(terms: [TermType], sorting: TermSorting<NumberType>, constant: NumberType) {
        self.terms = terms.merged().sorted(by: sorting)
        self.constant = constant
    }
}



// MARK: - Convenience Initializers
public extension PolynomialProtocol {

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


// MARK: - CustomStringConvertible
//extension Polynomial: CustomStringConvertible {}
public extension PolynomialProtocol {

    func sortingTerms(sorting: TermSorting<NumberType>) -> Self {
        return Self(terms: terms, sorting: sorting, constant: constant)
    }

    func asString(sorting betweenTerms: SortingBetweenTerms<NumberType>) -> String {
        return asString(sorting: TermSorting(betweenTerms: betweenTerms))
    }

    func asString(sorting: TermSorting<NumberType>) -> String {
        let sortedPolynomial = sortingTerms(sorting: sorting)
        return sortedPolynomial.description
    }

    var description: String {
        var constantString: String {
            guard constant != .zero else { return "" }
            let constantSignString = constant.isPositive ? "+" : "-"
            return " \(constantSignString) \(constant.absolute().shortFormat)"
        }

        var termsString: String {
            func termString(index: Int, term: TermType) -> String {
                let signStringIfNegative = term.isNegative ? term.signString : ""
                let signString = (index == 0 || index == terms.endIndex) ? "\(signStringIfNegative)" : " \(term.signString) "
                return "\(signString)\(term.description)"

            }
            return terms.enumerated().map { termString(index: $0, term: $1) }.joined()
        }

        return "\(termsString)\(constantString)"
    }
}

// MARK: - Equatable
//extension Polynomial: Equatable {}
public extension PolynomialProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.constant == rhs.constant
            && lhs.terms.sorted() == rhs.terms.sorted()
    }
}

// MARK: - Negatable
//extension Polynomial: Negatable {}
public extension PolynomialProtocol {
    func negated() -> Self {
        return Self(terms: terms.negated(), sorting: TermSorting<NumberType>(), constant: constant.negated())
    }
}

// MARK: - Solvable
//extension Polynomial: Solvable {}
public extension PolynomialProtocol {
    func solve(constants: Set<ConstantStruct<VariableType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
        guard uniqueVariables.isSubset(of: constants.map { $0.toVariable() }) else { return nil }
        let solution = terms.reduce(constant, {
            guard let solution = $1.solve(constants: constants, modulus: modulus, modulusMode: modulusMode) else { return $0 }
            return $0 + solution
        })
        guard let modulus = modulus else { return solution }
        return solution.mod(modulus, modulusMode: modulusMode)
    }
}




// MARK: - Public
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




// MARK: - PolynomialStruct

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
