//
//  Term.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum Term {
    case token(InfixToken)
    case tokens([InfixToken])
}

public extension Term {
    func toTokens() -> [InfixToken] {
        switch self {
        case .token(let token): return [token]
        case .tokens(let tokens): return tokens
        }
    }
}

// MARK: - NumericConververtible
extension Term: NumericConververtible {}
public extension Term {
    func solveNumeric() -> Int? {
        switch self {
        case .token(let token): return token.value
        case .tokens(let tokens): return Equation(infix: tokens).solveNumeric()
        }
    }

    func hasNumericSolution() -> Bool {
        switch self {
        case .token(let token): return !token.isUnsetVariable
        case .tokens(let tokens): return !tokens.containsUnsetVariable()
        }
    }
}

// MARK: - CustomStringConvertible
public extension Term {
    public var description: String {
        switch self {
        case .token(let token): return token.description
        case .tokens(let tokens): return tokens.description
        }
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension Term: ExpressibleByIntegerLiteral {}
public extension Term {
    init(integerLiteral value: Int) {
        self = .token(InfixToken.operand(.constant(value)))
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Term: ExpressibleByArrayLiteral {}
public extension Term {

    init(_ tokens: [InfixToken]) {
        self = .tokens(tokens)
    }

    init(arrayLiteral elements: InfixToken...) {
        self.init(elements)
    }
}
