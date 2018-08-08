//
//  Operator.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum Operator: String {
    case add = "+"
    case sub = "-"
    case mul = "*"
    case div = "/"
    case mod = "%"
    case pow = "^"

    public enum Associativity {
        case none
        case left
        case right
    }

    public enum Precedence: Int {
        case addition = 0
        case multiplication = 5
        case power = 10
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

// MARK: - ExpressibleByStringLiteral
extension Operator: ExpressibleByStringLiteral {}
public extension Operator {
    init(stringLiteral value: String) {
        if let `operator` = Operator(rawValue: value) {
            self = `operator`
        } else {
            fatalError("oh oh")
        }
    }
}

extension Operator.Precedence: Comparable {}
public extension Operator.Precedence {
    static func < (lhs: Operator.Precedence, rhs: Operator.Precedence) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    static func == (lhs: Operator.Precedence, rhs: Operator.Precedence) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
