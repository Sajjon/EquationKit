//
//  ReversePolishNotation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation


/// Reverse Polish Notation
/// https://en.wikipedia.org/wiki/Reverse_Polish_notation
public class ReversePolishNotation {

    public static func evaluate(_ tokens: [Token]) -> Int {
        var stack = [Int]()

        for token in tokens {
            if let value = token.value {
                stack.append(value)
            } else if let `operator` = token.asOperator() {
                let function = `operator`.function
                let rhs = stack.removeLast()
                let lhs = stack.removeLast()
                let value = function(lhs, rhs)
                stack.append(value)
            } else { fatalError("unexpected") }
        }

        let value = stack.first ?? 0
        return value
    }

}

/// https://en.wikipedia.org/wiki/Shunting-yard_algorithm
public func reversePolishNotationFrom(infix: [Token]) -> [Token] {
    var tokenStack = [Token]()
    var reversePolishNotation = [Token]()

    for token in infix {
        switch token {
        case .operand(_):
            reversePolishNotation.append(token)

        case .parenthesis(let parenthesis):
            switch parenthesis {
            case .left: tokenStack.append(token)
            case .right:
                while tokenStack.count > 0, case let top = tokenStack.removeLast(), !top.isLeftParenthesis {
                    reversePolishNotation.append(top)
                }
            }

        case .operator(let `operator`):
            for tempToken in tokenStack {
                guard
                    case let .operator(tempOperatorToken) = tempToken,
                    (
                        `operator`.associativity == .left && `operator`.precedence <= tempOperatorToken.precedence
                            ||
                            `operator`.associativity == .right && `operator`.precedence < tempOperatorToken.precedence
                    )
                    else { break }
                reversePolishNotation.append(tokenStack.removeLast())
            }
            tokenStack.append(token)
        }
    }

    while tokenStack.count > 0, case let tmpToken = tokenStack.removeLast() {
        guard !tmpToken.isParenthesis else { continue }
        reversePolishNotation.append(tmpToken)
    }

    reversePolishNotation = reversePolishNotation.filter { !$0.isParenthesis }

    return reversePolishNotation
}
