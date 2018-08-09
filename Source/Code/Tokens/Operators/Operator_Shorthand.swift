//
//  Operator_Shorthand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: Unary
public extension Operator {
    static func abs(_ n: Equation) -> Operator {
        return .unary(.absolute(n))
    }

    static func abs(_ n: Operand) -> Operator {
        return .unary(.absolute(n))
    }

    static func sqrt(_ n: Equation) -> Operator {
        return .unary(.squareRoot(n))
    }

    static func sqrt(_ n: Operand) -> Operator {
        return .unary(.squareRoot(n))
    }
}

// MARK: Binary
public extension Operator {
    static var add: Operator {
        return .binary(.add)
    }

    static var sub: Operator {
        return .binary(.sub)
    }

    static var mul: Operator {
        return .binary(.mul)
    }

    static var div: Operator {
        return .binary(.div)
    }

    static var mod: Operator {
        return .binary(.mod)
    }

    static var pow: Operator {
        return .binary(.pow)
    }
}

// MARK: Ternary
public extension Operator {
    static func modInverse(_ a: Equation, _ b: Equation, mod p: Equation) -> Operator {
        return .ternary(.modInverse(a, b, p))
    }
}
