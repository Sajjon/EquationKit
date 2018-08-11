//
//  Operand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum Operand {
    case constant(Int)
    case variable(Variable)
}

// MARK: - NumericConververtible
extension Operand: NumericConververtible {}
public extension Operand {
    func solveNumeric() -> Int? {
        return value
    }

    public func hasNumericSolution() -> Bool {
        return !isUnsetVariable
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension Operand: ExpressibleByIntegerLiteral {}
public extension Operand {
    public init(integerLiteral value: Int) {
        self = .constant(value)
    }
}

public extension Operand {
    var value: Int? {
        switch self {
        case .constant(let constant): return constant
        case .variable(let variable): return variable.value
        }
    }

    func asVariable() -> Variable? {
        switch self {
        case .variable(let variable): return variable
        default: return nil
        }
    }

    var isUnsetVariable: Bool {
        switch self {
        case .variable(let variable): return variable.value == nil
        default: return false
        }
    }
}

// MARK: - CustomStringConvertible
extension Operand: CustomStringConvertible {}
public extension Operand {
    var description: String {
        switch self {
        case .constant(let value): return "\(value)"
        case .variable(let variable): return variable.description
        }
    }
}
