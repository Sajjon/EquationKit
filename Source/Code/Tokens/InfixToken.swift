//
//  InfixToken.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum InfixToken {
    case `operator`(Operator)
    case operand(Operand)
    case parenthesis(Parenthesis)
}

public extension InfixToken {
    init(_ reversePolishToken: ReversePolishToken) {
        switch reversePolishToken {
        case .operand(let constant):
            self = .operand(.constant(constant))
        case .operator(let `operator`):
            self = .operator(`operator`)
        }
    }
}

// MARK: - TokenRepresentation
extension InfixToken: TokenRepresentation {}
public extension InfixToken {

    var isUnsetVariable: Bool {
        switch self {
        case .operand(let operand): return operand.isUnsetVariable
        default: return false
        }
    }

}

// MARK: - ExpressibleByIntegerLiteral
extension InfixToken: ExpressibleByIntegerLiteral {}
public extension InfixToken {
    init(integerLiteral value: Int) {
        self = .operand(.constant(value))
    }
}

// MARK: - CustomStringConvertible
extension InfixToken: CustomStringConvertible {}
public extension InfixToken {
    var description: String {
        switch self {
        case .operand(let operand): return operand.description
        case .operator(let `operator`): return `operator`.description
        case .parenthesis(let parenthesis): return parenthesis.description
        }
    }
}

// MARK: - Public
public extension InfixToken {
    func asOperand() -> Operand? {
        switch self {
        case .operand(let operand): return operand
        default: return nil
        }
    }

    func asOperator() -> Operator? {
        switch self {
        case .operator(let `operator`): return `operator`
        default: return nil
        }
    }

    var variable: Variable? {
        return asOperand()?.asVariable()
    }

    var value: Int? {
        return asOperand()?.value
    }

    var isParenthesis: Bool {
        switch self {
        case .parenthesis: return true
        default: return false
        }
    }

    var isLeftParenthesis: Bool {
        switch self {
        case .parenthesis(let parenthesis): return parenthesis.isLeft
        default: return false
        }
    }

    var isOperator: Bool {
        switch self {
        case .operator: return true
        default: return false
        }
    }
}
