//
//  Operand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum Operand: CustomStringConvertible {
    case number(Int)
    case variable(Variable)
}

extension Operand {
    var description: String {
        switch self {
        case .number(let number): return number.description
        case .variable(let variable): return variable.description
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
