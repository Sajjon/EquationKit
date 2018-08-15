//
//  Term.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Term {

    /// -1 if negative
    public let coefficient: Double
    public let exponentiations: [Exponentiation]

    init(exponentiations: [Exponentiation], coefficient: Double = 1) {
        guard coefficient != 0 else { fatalError("You probably don't want a Zero coefficient") }
        self.exponentiations = Term.sortingExponentiation(exponentiations)
        self.coefficient = coefficient
    }
}

// MARK: - Convenience Initializers
public extension Term {

    init(exponentiation: Exponentiation, coefficient: Double = 1) {
        self.init(exponentiations: [exponentiation], coefficient: coefficient)
    }

    init(_ variable: Variable) {
        self.init(exponentiation: Exponentiation(variable))
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
        precondition(Term.sortingExponentiation(exponentiations) == exponentiations) // TODO remove this when tested
        return exponentiations[0].exponent
    }

    var uniqueVariables: Set<Variable> {
        return Set(exponentiations.map { $0.variable })
    }

    var lowestVariableNameInAlpabeticOrder: String {
        return exponentiations.sorted(by: { $0.variable.name < $1.variable.name })[0].variable.name
    }

    static func sortingExponentiation(_ exponentiations: [Exponentiation]) -> [Exponentiation] {
        return exponentiations.sorted(by: { $0.exponent > $1.exponent }).sorted(by: { $0.variable.name < $1.variable.name })
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
            if let differentiationResult = exponentiation.differentiateWithRespectTo(variableToDifferentiate) {
                switch differentiationResult {
                case .constant(let differentiationConstant):
                    coefficientFromConstants *= differentiationConstant
                case .exponentiation(let differentiationCoefficient, let differentiationExponentiation):
                    if let differentiationCoefficient = differentiationCoefficient {
                        coefficient *= differentiationCoefficient
                    }
                    exponentiations.append(differentiationExponentiation)
                }

            } else {
                exponentiations.append(exponentiation)
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
        return lhs.exponentiations == rhs.exponentiations
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

