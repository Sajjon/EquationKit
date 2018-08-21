//
//  Term.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Term: Algebraic {

    /// -1 if negative
    public let coefficient: Double
    public let exponentiations: [Exponentiation]

    init(exponentiations: [Exponentiation], sorting: [SortingWithinTerm] = .default, coefficient: Double = 1) {
        guard coefficient != 0 else { fatalError("You probably don't want a Zero coefficient") }
        self.exponentiations = exponentiations.merged().sorted(by: sorting)
        self.coefficient = coefficient
    }
}

// MARK: - Convenience Initializers
public extension Term {

    init(_ exponentiations: Exponentiation..., coefficient: Double = 1) {
        self.init(exponentiations: exponentiations, coefficient: coefficient)
    }

    init(exponentiation: Exponentiation, coefficient: Double = 1) {
        self.init(exponentiations: [exponentiation], coefficient: coefficient)
    }

    init(_ variable: Variable) {
        self.init(exponentiation: Exponentiation(variable))
    }

    /// Use this as short hand when you want to write `x*y*z` which does not compile, nor does `(x*y)*z` nor `x(*y*z)`, but using this initializer enables you to write `Term(x*y)*z` which is equivalent to `((x*y) as Term)*z` but more easiliy readable.
    /// - See Also: `init(_ variables: [Variable])` for using `Term(x, y, z)`
    init(_ term: Term) {
        self.init(exponentiations: term.exponentiations, coefficient: term.coefficient)
    }

    init(_ variables: [Variable]) {
        self.init(exponentiations: variables.map { Exponentiation($0) })
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
//        return exponentiations[0].variable.name
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
//extension Term: Comparable {}
//private extension Term {
//
//    var isPositive: Bool {
//        return coefficient >= 0
//    }
//
//    func compare(to other: Term) -> ComparisonResult {
//        switch (isPositive, other.isPositive) {
//        case (false, true): return .orderedAscending
//        default: break
//        }
//
//        if exponentiations > other.exponentiations { return .orderedDescending }
//        if exponentiations < other.exponentiations { return .orderedAscending }
//
////        if coefficient > other.coefficient { return .orderedDescending }
////        if coefficient < other.coefficient { return .orderedAscending }
//
//        return .orderedSame
//    }
//}
//
//public extension Term {
//    static func < (lhs: Term, rhs: Term) -> Bool {
//        return lhs.compare(to: rhs) == .orderedAscending
//    }
//
//    static func > (lhs: Term, rhs: Term) -> Bool {
//        return lhs.compare(to: rhs) == .orderedDescending
//    }
//}

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

// MARK: - Appending
public extension Term {

    func appending(term other: Term) -> Term {
            // e.g. (2*x*y) * (3x^2*y^2)
        return Term(exponentiations: exponentiations + other.exponentiations, coefficient: coefficient*other.coefficient)
    }

    func appending(exponentiation: Exponentiation) -> Term {
        return appending(term: Term(exponentiation: exponentiation))
    }

    func appending(variable: Variable) -> Term {
        return appending(exponentiation: Exponentiation(variable))
    }
}

// MARK: - Multiplying
public extension Term {
    func multiplyingCoefficient(by number: Double) -> Term {
        return Term(exponentiations: exponentiations, coefficient: coefficient * number)
    }

    func multiplyingExponent(by number: Double) -> Term {
        guard let lastExponentiation = self.exponentiations.last else { fatalError("Terms should have at least one exponentation") }
        let modified = lastExponentiation.multiplyingExponent(by: number)
        var exponentiations = [modified]
        if exponentiations.count > 1 {
            exponentiations = self.exponentiations.dropLast() + exponentiations
        }
        return Term(exponentiations: exponentiations, coefficient: coefficient)
    }
}
