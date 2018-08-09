//
//  ReversePolishNotation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct ReversePolishNotation {
    public let tokens: [ReversePolishToken]

    public init(_ tokens: [ReversePolishToken]) {
        self.tokens = tokens
    }
}

// MARK: - EquationRepresentation
extension ReversePolishNotation: EquationRepresentation {}
public extension ReversePolishNotation {

    func toReversePolishNotation() -> ReversePolishNotation {
        return self
    }

    func solveNumeric() -> Int? {
        var stack = [Int]()

        for token in tokens {
            switch token {
            case .operand(let operand):
                stack.append(operand)
            case .operator(let `operator`):
                let operands = stack.pop(`operator`.arity)
                let function = `operator`.function
                stack.append(function(operands))
            }
        }
        return stack.first
    }

    func toInfixNotation() -> InfixNotation {
        var terms = [Term]()

        for token in tokens {
            switch token {
            case .operand(let operand):
                let term: Term = .token(.operand(.constant(operand)))
                terms.append(term)
            case .operator(let `operator`):
                guard terms.count >= `operator`.arity else { fatalError("too few operands") }
                let rhs = terms.removeLast().toTokens()
                let lhs = terms.removeLast().toTokens()
                let op = InfixToken(token)
                terms.append(.tokens(
                    ﹙ + lhs + op + rhs + ﹚
                    ))
            }
        }

        return InfixNotation(terms.flatMap { $0.toTokens() })
    }

}
