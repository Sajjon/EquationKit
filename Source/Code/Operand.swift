//
//  Operand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum Operand: CustomStringConvertible {
    struct Variable: CustomStringConvertible {
        let name: String
        let value: Int?

        init(_ name: String, value: Int? = nil) {
            self.name = name
            self.value = value
        }

        var description: String {
            let valueString = value != nil ? " value: \(value!)" : ""
            return "\(name)\(valueString)"
        }
    }
    case constant(Int)
    case variable(Variable)

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

    var description: String {
        switch self {
        case .constant(let value): return "\(value)"
        case .variable(let variable): return variable.description
        }
    }

    var isUnsetVariable: Bool {
        switch self {
        case .variable(let variable): return variable.value == nil
        default: return false
        }
    }
}
