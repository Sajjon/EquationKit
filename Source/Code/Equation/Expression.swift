//
//  Expression.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum Expression {
    indirect case `operator`(Operator)
    case operand(Operand)

    func equals(other: Expression) -> Bool {
        switch (self, other) {
        case (.operator(let selfOp), .operator(let otherOp)): return selfOp.equals(other: otherOp)
        case (.operand(let selfOp), .operand(let otherOp)): return selfOp == otherOp
        default: return false
        }
    }
}

protocol Differentiatable {
    func differentiated(withRespectTo variable: Variable) -> Expression
}

extension Operand: Differentiatable {
    func differentiated(withRespectTo variable: Variable) -> Expression {
        return .operand(self)
//        switch self {
//        case .number: return .number(0)
//        case .variable(let inner):
//            guard inner == variable else { return self }
//            return .number(1)
//        }
    }
}

extension Expression: Differentiatable {
    func differentiated(withRespectTo variable: Variable) -> Expression {
        print("differentiating: `\(self)`")
        switch self {
        case .operand(let operand): return operand.differentiated(withRespectTo: variable)
        case .operator(let `operator`): return `operator`.differentiated(withRespectTo: variable)
        }
    }
}

func differentiate(expression: Expression, withRespectTo variable: Variable) -> Expression {
    print("differentiating: `\(expression)`")
    return expression.differentiated(withRespectTo: variable)
}

extension Expression: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        switch self {
        case .`operator`(let `operator`): return `operator`.description
        case .operand(let operand): return operand.description
        }
    }

    var debugDescription: String {
        switch self {
        case .`operator`(let `operator`): return `operator`.debugDescription
        case .operand(let operand): return operand.debugDescription
        }
    }
}

extension Expression {
    var number: Int? {
        switch self {
        case .operand(let operand): return operand.number
        default: return nil
        }
    }

    var variable: Variable? {
        switch self {
        case .operand(let operand): return operand.variable
        default: return nil
        }
    }

    func asOperator() -> Operator? {
        switch self {
        case .operator(let `operator`): return `operator`
        default: return nil
        }
    }
}


extension Expression {
    static func number(_ int: Int) -> Expression {
        return .operand(.number(int))
    }

    static func variable(_ variable: Variable) -> Expression {
        return .operand(.variable(variable))
    }

}
