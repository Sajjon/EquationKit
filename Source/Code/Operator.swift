//
//  Operator.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum Operator: String, ExpressibleByStringLiteral {

    enum Associativity {
        case none
        case left
        case right
    }

    enum Precedence: Int, Comparable {
        // Ascending order
        case addition = 0
        case multiplication = 5
        case power = 10

        static func < (lhs: Precedence, rhs: Precedence) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }

        static func == (lhs: Precedence, rhs: Precedence) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }

    case add = "+"
    case sub = "-"
    case mul = "*"
    case div = "/"
    case mod = "%"
    case pow = "^"

    init(stringLiteral value: String) {
        if let `operator` = Operator(rawValue: value) {
            self = `operator`
        } else {
            fatalError("oh oh")
        }
    }

    var associativity: Associativity {
        switch self {
        case .pow: return .right
        default: return .left
        }
    }

    var precedence: Precedence {
        switch self {
        case .add: return .addition
        case .sub: return .addition
        case .mul: return .multiplication
        case .div: return .multiplication
        case .mod: return .multiplication
        case .pow: return .power
        }
    }
}
