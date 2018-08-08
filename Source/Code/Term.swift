//
//  Term.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum Term: ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral {
    case token(Token)
    case tokens([Token])
    func toTokens() -> [Token] {
        switch self {
        case .token(let token): return [token]
        case .tokens(let tokens): return tokens
        }
    }

    init(integerLiteral value: Int) {
        self = .token(Token.operand(.constant(value)))
    }

    init(arrayLiteral elements: Token...) {
        self = .tokens(elements)
    }
}
