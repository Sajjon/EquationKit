//
//  Exponentiation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Exponentiation {
    
    public let variable: Variable
    public let exponent: Double

    init(_ variable: Variable, exponent: Double = 1) {
        self.variable = variable
        self.exponent = exponent
    }
}

// MARK: - Convenience Initializers
public extension Exponentiation {
    init(_ name: String, exponent: Double = 1) {
        self.init(Variable(name), exponent: exponent)
    }
}

// MARK: - Solvable
extension Exponentiation: Solvable {}
public extension Exponentiation {
    func solve(constants: Set<Constant>, modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard let constant = constants.first(where: { $0.toVariable() == variable }) else { return nil }
        let value = pow(constant.value, exponent)
        guard let modulus = modulus else { return value }
        return mod(value, modulus: modulus, modulusMode: modulusMode)
    }
}

// MARK: - Differentiatable
extension Exponentiation: Differentiatable {}
public extension Exponentiation {

    public enum DifferentiationResult {
        case constant(Double)
        case exponentiation(coefficient: Double?, exponentiation: Exponentiation)
    }

    /// Returns the differentiated variable and its coefficient with respect to the input variable, if this variable does not equal said variable, then this method returns `nil`
    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> DifferentiationResult? {
        guard variableToDifferentiate == variable else { return .exponentiation(coefficient: nil, exponentiation: self) }
        let exponentPriorToDifferentiation = self.exponent
        let exponent = exponentPriorToDifferentiation - 1
        guard exponent > 0 else {
            return .constant(1)
        }
        return .exponentiation(coefficient: exponentPriorToDifferentiation, exponentiation: Exponentiation(variable, exponent: exponent))
    }

}

// MARK: - Hashable
extension Exponentiation: Hashable {}

// MARK: - Equatable
extension Exponentiation: Equatable {}
public extension Exponentiation {
    static func == (lhs: Exponentiation, rhs: Exponentiation) -> Bool {
        return lhs.variable == rhs.variable && lhs.exponent == rhs.exponent
    }
}

// MARK: - CustomStringConvertible
extension Exponentiation: CustomStringConvertible {}
public extension Exponentiation {
    var description: String {
        guard exponent != 1 else { return variable.description }
        if exponent > 1 && exponent < 10 {
            let superscript: String
            if exponent == 2 {
                superscript = "²"
            } else if exponent == 3 {
                superscript = "³"
            } else if exponent == 4 {
                superscript = "⁴"
            } else if exponent == 5 {
                superscript = "⁵"
            } else if exponent == 6 {
                superscript = "⁶"
            } else if exponent == 7 {
                superscript = "⁷"
            } else if exponent == 8 {
                superscript = "⁸"
            } else if exponent == 9 {
                superscript = "⁹"
            } else { fatalError("forgot number") }
            return "\(variable)\(superscript)"
        } else {
            return "\(variable)^\(exponent.shortFormat)"
        }
    }

}

// MARK: Multiplying
public extension Exponentiation {
    func multiplyingExponent(by number: Double) -> Exponentiation {
        return Exponentiation(variable, exponent: exponent * number)
    }
}
