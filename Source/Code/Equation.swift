//
//  Equation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Equation {
    public let infix: InfixNotation

    public init(infix: InfixNotation) {
        self.infix = infix
    }
}

// MARK: - EquationRepresentation
extension Equation: EquationRepresentation {}
public extension Equation {
    var tokens: [InfixToken] {
        return infix.tokens
    }

    func solveNumeric() -> Int? {
        return infix.solveNumeric()
    }

    func toInfixNotation() -> InfixNotation {
        return infix
    }

    func toReversePolishNotation() -> ReversePolishNotation {
        return infix.toReversePolishNotation()
    }
}

// MARK: - Convenience Initializers
public extension Equation {

    init(infix tokens: [InfixToken]) {
        self.init(infix: InfixNotation(tokens))
    }

    init(infix terms: [Term]) {
        self.init(infix: terms.flatMap { $0.toTokens() })
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Equation: ExpressibleByArrayLiteral {}
public extension Equation {
    init(arrayLiteral elements: InfixToken...) {
        self.init(infix: elements)
    }
}


// MARK: - ExpressibleByIntegerLiteral
extension Equation: ExpressibleByIntegerLiteral {}
public extension Equation {
    public init(integerLiteral value: Int) {
        self.init(infix: [.operand(.constant(value))])
    }
}

// MARK: - CustomStringConvertible
extension Equation: CustomStringConvertible {}
public extension Equation {
    var description: String {
        return infix.tokens.map { $0.description }.joined(separator: " ")
    }
}

public extension Equation {
    func differentiate() -> Equation {
        return toReversePolishNotation().differentiate()
    }
}
