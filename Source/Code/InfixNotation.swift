//
//  InfixNotation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct InfixNotation {
    public let tokens: [InfixToken]

    public init(_ tokens: [InfixToken]) {
        self.tokens = tokens
    }
}

// MARK: - EquationRepresentation
extension InfixNotation: EquationRepresentation {}
public extension InfixNotation {
    func toInfixNotation() -> InfixNotation {
        return self
    }

    func solveNumeric() -> Int? {
        guard hasNumericSolution() else { return nil }
        return toReversePolishNotation().solveNumeric()
    }

    /// https://en.wikipedia.org/wiki/Shunting-yard_algorithm
    func toReversePolishNotation() -> ReversePolishNotation {
        var infix = [InfixToken]()
        var reversePolish = [ReversePolishToken?]()

        for token in tokens {
            switch token {
            case .operand: reversePolish.append(ReversePolishToken(infix: token))

            case .parenthesis(let parenthesis):
                switch parenthesis {
                case .left: infix.append(token)
                case .right:
                    while infix.count > 0, case let top = infix.removeLast(), !top.isLeftParenthesis {
                        reversePolish.append(ReversePolishToken(infix: top))
                    }
                }

            case .operator(let `operator`):
                for tempToken in infix {
                    guard
                        case let .operator(tempOperatorToken) = tempToken,
                        (
                            `operator`.associativity == .left && `operator`.precedence <= tempOperatorToken.precedence
                                ||
                                `operator`.associativity == .right && `operator`.precedence < tempOperatorToken.precedence
                        )
                        else { break }
                    reversePolish.append(ReversePolishToken(infix: infix.removeLast()))
                }
                infix.append(token)
            }
        }

        while infix.count > 0, let tmpToken = ReversePolishToken(infix: infix.removeLast()) {
            reversePolish.append(tmpToken)
        }

        return ReversePolishNotation(reversePolish.compactMap { $0 })
    }

}
