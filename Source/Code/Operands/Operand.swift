//
//  Operand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum Operand: CustomStringConvertible, CustomDebugStringConvertible {
    case number(Int)
    case variable(Variable)
}

extension Operand: Negatable {
    func negated() -> Operand {
        switch self {
        case .number(let number): return .number(number.negated())
        case .variable(let variable): return .variable(variable.negated())
        }
    }
}

extension Operand {
    var description: String {
        switch self {
        case .number(let number): return number.description
        case .variable(let variable): return variable.description
        }
    }

    var debugDescription: String {
        switch self {
        case .number(let number): return number.description
        case .variable(let variable): return variable.debugDescription
        }
    }
}

extension Operand {
    var number: Int? {
        switch self {
        case .number(let number): return number
        default: return nil
        }
    }

    var variable: Variable? {
        switch self {
        case .variable(let variable): return variable
        default: return nil
        }
    }

    var isNumber: Bool { return number != nil }
}
