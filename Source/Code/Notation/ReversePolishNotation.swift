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
                let value: Int
                switch `operator` {
                case .unary(let unaryOperator):
                    value = try! unaryOperator.function() as! Int
                case .binary(let binaryOperator):
                    let operands = stack.pop(`operator`.arity)
                    value = try! binaryOperator.function(operands) as! Int
                case .ternary(let ternaryOperator):
                    value = try! ternaryOperator.function() as! Int
                }
                stack.append(value)
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
