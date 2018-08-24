//
//  Exponentiation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol ExponentiationProtocol: Differentiatable, Algebraic, Comparable where PolynomialType.TermType.ExponentiationType == Self, PolynomialType.NumberType == Self.NumberType {
    var variable: VariableType { get }
    var exponent: NumberType { get }
    init(variable: VariableType, exponent: NumberType)
}

// MARK: - Convenience Initializers
public extension ExponentiationProtocol {
    init(_ variable: VariableType, exponent: NumberType = .one) {
        self.init(variable: variable, exponent: exponent)
    }

    init(_ name: String, exponent: NumberType = .one) {
        self.init(VariableType(name), exponent: exponent)
    }
}

public typealias Exponentiation = ExponentiationStruct<Double>

public struct ExponentiationStruct<Number: NumberExpressible>: ExponentiationProtocol {
    public typealias PolynomialType = PolynomialStruct<Number>
    public typealias VariableType = VariableStruct<Number>

    public typealias NumberType = Number
    public let variable: VariableType
    public let exponent: NumberType

    public init(variable: VariableType, exponent: NumberType) {
        self.variable = variable
        self.exponent = exponent
    }
}


// MARK: - Solvable
//extension Exponentiation: Solvable {}
public extension ExponentiationProtocol {
    func solve(constants: Set<ConstantStruct<VariableType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
        guard let matchingVariable = constants.first(where: { $0.toVariable() == variable }) else { return nil }
        let value = matchingVariable.value.raised(to: exponent)
        guard let modulus = modulus else { return value }
        return value.mod(modulus, modulusMode: modulusMode)
    }
}


// MARK: - Hashable
//extension Exponentiation: Hashable {}

// MARK: - Equatable
//extension ExponentiationProtocol: Equatable {}
public extension ExponentiationProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.variable == rhs.variable && lhs.exponent == rhs.exponent
    }
}

// MARK: - Compareable
extension ExponentiationProtocol {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return [rhs, lhs].sorted() == [lhs, rhs]
    }
}

// MARK: - CustomStringConvertible
//extension Exponentiation: CustomStringConvertible {}
public extension ExponentiationProtocol {
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
public extension ExponentiationProtocol {
    func multiplyingExponent(by number: NumberType) -> Self {
        return Self(variable, exponent: exponent * number)
    }
}
