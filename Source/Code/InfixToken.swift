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

//// MARK: - ExpressibleByStringLiteral
//extension InfixToken: ExpressibleByStringLiteral {}
//public extension InfixToken {
//    init(stringLiteral value: String) {
//        guard let `operator` = Operator(rawValue: value) else { fatalError("cannot create operator") }
//        self = .operator(`operator`)
//    }
//}

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

    var pow: Operator? {
        guard let `operator` = asOperator(), `operator` == .pow else { return nil }
        return `operator`
    }
}

public extension InfixToken {
    static var add: InfixToken {
        return .operator(.add)
    }

    static var sub: InfixToken {
        return .operator(.sub)
    }

    static var mul: InfixToken {
        return .operator(.mul)
    }

    static var div: InfixToken {
        return .operator(.div)
    }

    static var mod: InfixToken {
        return .operator(.mod)
    }

    static var pow: InfixToken {
        return .operator(.pow)
    }
}
