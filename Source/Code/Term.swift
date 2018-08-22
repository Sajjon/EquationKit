//
//  Term.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol TermProtocol: Algebraic, Negatable, Comparable, CustomDebugStringConvertible where ExponentiationType.NumberType == Self.NumberType {
    associatedtype NumberType // NumberExpressible
    associatedtype ExponentiationType: ExponentiationProtocol
    var coefficient: NumberType { get }
    var exponentiations: [ExponentiationType] { get }
    init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm], coefficient: NumberType)
}

public extension TermProtocol {
    public init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm] = .default, coefficient: NumberType = .one) {
        self.init(exponentiations: exponentiations, sorting: sorting, coefficient: coefficient)
    }

}

public struct Term: TermProtocol {

    /// -1 if negative
    public typealias NumberType = Double
    public typealias ExponentiationType = Exponentiation
    public let coefficient: NumberType
    public let exponentiations: [ExponentiationType]

    public init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm], coefficient: NumberType) {
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

    init(exponentiation: ExponentiationType, coefficient: NumberType = .one) {
        self.init(exponentiations: [exponentiation], coefficient: coefficient)
    }

    init(_ variable: Variable) {
        self.init(exponentiation: ExponentiationType(variable))
    }

    init(_ variables: [Variable]) {
        self.init(exponentiations: variables.map { ExponentiationType($0) })
    }

    init(_ variables: Variable...) {
        self.init(variables)
    }

}

// MARK: - Public
public extension Term {
    var isNegative: Bool {
        return coefficient < 0
    }

    func contains(variable: Variable) -> Bool {
        return exponentiations.map { $0.variable }.contains(variable)
    }
}

// MARK: - Internal
internal extension Term {

    var signString: String {
        return isNegative ? "-" : "+"
    }

    var highestExponent: Double {
        return exponentiations.sorted(by: .descendingExponent)[0].exponent
    }

    var uniqueVariables: Set<Variable> {
        return Set(exponentiations.map { $0.variable })
    }

    var variableNames: String {
        return exponentiations.map { $0.variable.name }.joined()
    }
}

// MARK: - Negatable
extension Term: Negatable {}
public extension Term {
    func negated() -> Term {
        return Term(exponentiations: exponentiations, coefficient: -coefficient)
    }
}

// MARK: - Solvable
extension Term: Solvable {}
public extension Term {
    func solve(constants: Set<Constant>, modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard uniqueVariables.isSubset(of: constants.map { $0.toVariable() }) else { return nil }
        let values = exponentiations.compactMap { $0.solve(constants: constants, modulus: modulus, modulusMode: modulusMode) }
        return values.reduce(1, { $0*$1 }) * coefficient
    }
}

// MARK: - Differentiatable
extension Term: Differentiatable {}
public extension Term {

    public enum DifferentiationResult {
        case constant(Double)
        case term(Term)
    }

    /// Returns the differentiated term with respect to the input variable, if this term does not contain said variable, then this method returns `nil`
    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> DifferentiationResult? {

        guard contains(variable: variableToDifferentiate) else { return nil }

        var exponentiations = [Exponentiation]()
        var coefficient = self.coefficient
        var coefficientFromConstants: Double = 1
        for exponentiation in self.exponentiations {
            guard let differentiationResult = exponentiation.differentiateWithRespectTo(variableToDifferentiate) else { exponentiations.append(exponentiation); continue }
            switch differentiationResult {
            case .constant(let differentiationConstant):
                coefficientFromConstants *= differentiationConstant
            case .exponentiation(let differentiationCoefficient, let differentiationExponentiation):
                if let differentiationCoefficient = differentiationCoefficient {
                    coefficient *= differentiationCoefficient
                }
                exponentiations.append(differentiationExponentiation)
            }
        }

        if exponentiations.count == 0 {
            return .constant(coefficient * coefficientFromConstants)
        } else {
            let term = Term(exponentiations: exponentiations, coefficient: coefficient * coefficientFromConstants)
            return .term(term)
        }

    }

}

// MARK: - Equatable
extension Term: Equatable {}
public extension Term {
    static func == (lhs: Term, rhs: Term) -> Bool {
        return lhs.exponentiations.sorted() == rhs.exponentiations.sorted() && lhs.coefficient == rhs.coefficient
    }
}

// MARK: - Comparable
extension Term: Comparable {
    public static func < (lhs: Term, rhs: Term) -> Bool {
        return [rhs, lhs].sorted() == [lhs, rhs]
    }
}

// MARK: - Hashable
extension Term: Hashable {}
public extension Term {
    var hashValue: Int {
        return exponentiations.hashValue
    }
}

// MARK: - CustomStringConvertible
extension Term: CustomStringConvertible {}
public extension Term {

    func sortingExponentiations(by sorting: [SortingWithinTerm] = .default) -> Term {
        return Term(exponentiations: exponentiations, sorting: sorting, coefficient: coefficient)
    }

    func sortingExponentiations(by sorting: SortingWithinTerm) -> Term {
        return sortingExponentiations(by: [sorting])
    }

    func asString(sorting: SortingWithinTerm) -> String {
        return asString(sorting: [sorting])
    }

    func asString(sorting: [SortingWithinTerm] = .default) -> String {
        let sorted = sortingExponentiations(by: sorting)
        return sorted.description
    }

    var description: String {
        var exponentiationsString: String {
            return exponentiations.map { $0.description }.joined()
        }

        var coefficientString: String {
            let absoluteCoefficient = abs(coefficient)
            guard absoluteCoefficient != 1 else { return "" }
            return "\(absoluteCoefficient.shortFormat)"
        }

        return "\(coefficientString)\(exponentiationsString)"
    }
}

// MARK: - CustomDebugStringConvertible
extension Term: CustomDebugStringConvertible {}
public extension Term {
    var debugDescription: String {
        return "\(signString)\(description)"
    }
}
