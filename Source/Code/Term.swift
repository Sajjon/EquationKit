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
    init(arrayLiteral elements: InfixToken...) {
        self = .tokens(elements)
    }
}
