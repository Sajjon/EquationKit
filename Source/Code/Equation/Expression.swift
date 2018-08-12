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
