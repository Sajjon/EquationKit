//
//  InfixToken_Shorthand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: Binary Operators
public extension InfixToken {
    static func abs(_ n: Equation) -> InfixToken {
        return .operator(.abs(n))
    }

    static func abs(_ n: Operand) -> InfixToken {
        return .operator(.abs(n))
    }

    static func sqrt(_ n: Equation) -> InfixToken {
        return .operator(.abs(n))
    }

    static func sqrt(_ n: Operand) -> InfixToken {
        return .operator(.abs(n))
    }
}

// MARK: Binary Operators
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

// MARK: - Ternary Operators
public extension InfixToken {
    static func modInverse(_ a: Equation, _ b: Equation, mod p: Equation) -> InfixToken {
        return .operator(.modInverse(a, b, mod: p))
    }

    static func modInverse(_ a: Equation, _ b: Equation, mod p: [Term]) -> InfixToken {
        return modInverse(a, b, mod: Equation(infix: p))
    }

    static func modInverse(_ a: Equation, _ b: Equation, mod p: Term...) -> InfixToken {
        return modInverse(a, b, mod: p)
    }
}
