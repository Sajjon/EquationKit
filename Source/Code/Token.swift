//
//  Token.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum Token {
    case `operator`(Operator)
    case operand(Operand)
    case parenthesis(Parenthesis)
}

// MARK: - ExpressibleByStringLiteral
extension Token: ExpressibleByStringLiteral {}
public extension Token {
    init(stringLiteral value: String) {
        guard let `operator` = Operator(rawValue: value) else { fatalError("cannot create operand") }
        self = .operator(`operator`)
    }
}


extension Token: ExpressibleByIntegerLiteral {}
public extension Token {
    init(integerLiteral value: Int) {
        self = .operand(.constant(value))
    }
}

extension Token: CustomStringConvertible {}
public extension Token {
    var description: String {
        switch self {
        case .operand(let operand): return operand.description
        case .operator(let `operator`): return `operator`.rawValue
        case .parenthesis(let parenthesis): return parenthesis.rawValue
        }
    }
}

public extension Token {
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

    var isUnsetVariable: Bool {
        switch self {
        case .operand(let operand): return operand.isUnsetVariable
        default: return false
        }
    }

    var pow: Operator? {
        guard let `operator` = asOperator(), `operator` == .pow else { return nil }
        return `operator`
    }
}

public extension Token {
    static var add: Token {
        return .operator(.add)
    }

    static var sub: Token {
        return .operator(.sub)
    }

    static var mul: Token {
        return .operator(.mul)
    }

    static var div: Token {
        return .operator(.div)
    }

    static var mod: Token {
        return .operator(.mod)
    }

    static var pow: Token {
        return .operator(.pow)
    }
}
