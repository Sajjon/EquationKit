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

    /// In logic, mathematics, and computer science, the `arity` of a function or operation is the number of arguments or operands that the function takes.
    /// https://en.wikipedia.org/wiki/Arity
    var arity: Int {
        switch self {
        default:
            return 2
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

    public typealias Function = (Int, Int) -> Int
    var function: Function {
        switch self {
        case .add: return { $0 + $1 }
        case .sub: return { $0 - $1 }
        case .mul: return { $0 * $1 }
        case .div: return { $0 / $1 }
        case .mod: return { $0 % $1 }
        case .pow: return { $0 ** $1 }
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
