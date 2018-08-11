//
//  Equation_Shorthand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

private extension Equation {
    static func op(_ op: Operator) -> Equation {
        return Equation(infix: [InfixToken.operator(op)])
    }
}

public extension Equation {
    static func abs(eq: Equation) -> Equation {
        return op(.abs(eq))
    }

    static func abs(_ n: Operand) -> Equation {
        return op(.abs(n))
    }

    static func sqrt(_ n: Equation) -> Equation {
        return op(.sqrt(n))
    }

    static func sqrt(_ n: Operand) -> Equation {
        return op(.sqrt(n))
    }
}

public extension Equation {
    static func modInverse(_ a: Equation, _ b: Equation, mod p: Equation) -> Equation {
        return op(.modInverse(a, b, mod: p))
    }

    static func modInverse(_ a: Equation, _ b: Equation, mod p: [Term]) -> Equation {
        return modInverse(a, b, mod: Equation(infix: p))
    }

    static func modInverse(_ a: Equation, _ b: Equation, mod p: Term...) -> Equation {
        return modInverse(a, b, mod: p)
    }
}

