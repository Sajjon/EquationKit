//
//  Term.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol TermProtocol: Algebraic, Negatable, Differentiatable, Comparable, CustomDebugStringConvertible where ExponentiationType.NumberType == Self.NumberType, PolynomialType.NumberType == Self.NumberType, PolynomialType.TermType == Self, Self.ExponentiationType.PolynomialType == Self.PolynomialType, Self.ExponentiationType.VariableType == Self.VariableType {
    associatedtype ExponentiationType: ExponentiationProtocol
    var coefficient: NumberType { get }
    var exponentiations: [ExponentiationType] { get }
    init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm<NumberType>], coefficient: NumberType)
}







public extension TermProtocol {
    init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm<NumberType>] = SortingWithinTerm<NumberType>.defaultArray, coefficient: NumberType = .one) {
        self.init(exponentiations: exponentiations, sorting: sorting, coefficient: coefficient)
    }

    init(exponentiation: ExponentiationType, coefficient: NumberType = .one) {
        self.init(exponentiations: [exponentiation], coefficient: coefficient)
    }
}

public typealias Term = TermStruct<Double>

public struct TermStruct<Number: NumberExpressible>: TermProtocol {

    /// -1 if negative
    public typealias PolynomialType = PolynomialStruct<Number>
    public typealias NumberType = Number
    public typealias ExponentiationType = ExponentiationStruct<NumberType>
    public typealias VariableType = VariableStruct<NumberType>
    public let coefficient: NumberType
    public let exponentiations: [ExponentiationType]

    public init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm<NumberType>], coefficient: NumberType) {
        guard coefficient != 0 else { fatalError("You probably don't want a Zero coefficient") }
        self.exponentiations = exponentiations.merged().sorted(by: sorting)
        self.coefficient = coefficient
    }
}

// MARK: - Convenience Initializers
public extension TermProtocol {

    init(_ exponentiations: ExponentiationType..., coefficient: NumberType = .one) {
        self.init(exponentiations: exponentiations, coefficient: coefficient)
    }


    init(_ variable: VariableType) {
        self.init(exponentiation: ExponentiationType(variable))
    }

    init(_ variables: [VariableType]) {
        self.init(exponentiations: variables.map { ExponentiationType($0) })
    }

    init(_ variables: VariableType...) {
        self.init(variables)
    }

}

// MARK: - Public
public extension TermProtocol {
    var isNegative: Bool {
        return coefficient.isNegative
    }

    func contains(variable: VariableType) -> Bool {
        return exponentiations.map { $0.variable }.contains(variable)
    }
}

// MARK: - Internal
internal extension TermProtocol {

    var signString: String {
        return isNegative ? "-" : "+"
    }

    var highestExponent: NumberType {
        return exponentiations.sorted(by: .descendingExponent)[0].exponent
    }

    var uniqueVariables: Set<VariableType> {
        return Set(exponentiations.map { $0.variable })
    }

    var variableNames: String {
        return exponentiations.map { $0.variable.name }.joined()
    }
}

// MARK: - Negatable
//extension Term: Negatable {}
public extension TermProtocol {
    func negated() -> Self {
        return Self(exponentiations: exponentiations, coefficient: coefficient.negated())
    }
}

// MARK: - Solvable
//extension Term: Solvable {}
public extension TermProtocol {
    func solve(constants: Set<ConstantStruct<VariableType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
        guard uniqueVariables.isSubset(of: constants.map { $0.toVariable() }) else { return nil }
        let values = exponentiations.compactMap { $0.solve(constants: constants, modulus: modulus, modulusMode: modulusMode) }
        return values.reduce(1, { $0*$1 }) * coefficient
    }
}



// MARK: - Equatable
//extension Term: Equatable {}
public extension TermProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.exponentiations.sorted() == rhs.exponentiations.sorted() && lhs.coefficient == rhs.coefficient
    }
}

// MARK: - Comparable
extension TermProtocol {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return [rhs, lhs].sorted() == [lhs, rhs]
    }
}

// MARK: - Hashable
//extension Term: Hashable {}
public extension TermProtocol {
    var hashValue: Int {
        return exponentiations.hashValue
    }
}

// MARK: - CustomStringConvertible
//extension Term: CustomStringConvertible {}
public extension TermProtocol {

    func sortingExponentiations(by sorting: [SortingWithinTerm<NumberType>] = SortingWithinTerm<NumberType>.defaultArray) -> Self {
        return Self(exponentiations: exponentiations, sorting: sorting, coefficient: coefficient)
    }

    func sortingExponentiations(by sorting: SortingWithinTerm<NumberType>) -> Self {
        return sortingExponentiations(by: [sorting])
    }

    func asString(sorting: SortingWithinTerm<NumberType>) -> String {
        return asString(sorting: [sorting])
    }

    func asString(sorting: [SortingWithinTerm<NumberType>] = SortingWithinTerm<NumberType>.defaultArray) -> String {
        let sorted = sortingExponentiations(by: sorting)
        return sorted.description
    }

    var description: String {
        var exponentiationsString: String {
            return exponentiations.map { $0.description }.joined()
        }

        var coefficientString: String {
            let absoluteCoefficient = coefficient.absolute()
            guard absoluteCoefficient != .one else { return "" }
            return "\(absoluteCoefficient.shortFormat)"
        }

        return "\(coefficientString)\(exponentiationsString)"
    }
}

// MARK: - CustomDebugStringConvertible
//extension Term: CustomDebugStringConvertible {}
public extension TermProtocol {
    var debugDescription: String {
        return "\(signString)\(description)"
    }
}
