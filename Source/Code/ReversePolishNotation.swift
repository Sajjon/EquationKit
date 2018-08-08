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
        return evaluate(tokens: tokens.map { $0.description })
    }
}

// MARK: - Private
private extension ReversePolishNotation {
    static func evaluate(tokens: [String]) -> Int {
        var stack = [Int]()

        for token in tokens {
            if let num = Int(token) {
                stack.append(num)
            } else {
                let `operator` = token
                let post = stack.removeLast()
                let prev = stack.removeLast()
                stack.append(operate(prev, post, `operator`))
            }
        }

        let value = stack.first ?? 0
        return value
    }

    static func operate(_ prev: Int, _ post: Int, _ token: String) -> Int {
        switch token {
        case Operator.add.rawValue:
            return prev + post
        case Operator.sub.rawValue:
            return prev - post
        case Operator.mul.rawValue:
            return prev * post
        case Operator.div.rawValue:
            return prev / post
        case Operator.mod.rawValue:
            return prev % post
        case Operator.pow.rawValue:
            return prev ** post // right associative?
        default: fatalError("unsupported operation: `\(token)`")
        }
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
