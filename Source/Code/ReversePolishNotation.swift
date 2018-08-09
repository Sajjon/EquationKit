//
//  ReversePolishNotation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum OperandOrOperator {
    case operand(Int)
    case `operator`(Operator)
}

extension OperandOrOperator {
    init?(token: Token) {
        if let `operator` = token.asOperator() {
            self = .operator(`operator`)
        } else if let operand = token.asOperand(), let value = operand.value {
            self = .operand(value)
        } else {
            return nil
        }
    }
}

private extension Token {
    init(_ operandOrOperator: OperandOrOperator) {
        switch operandOrOperator {
        case .operand(let constant):
            self = .operand(.constant(constant))
        case .operator(let `operator`):
            self = .operator(`operator`)
        }
    }
}

private extension Array {
    mutating func removeLastTwo() -> (lhs: Element, rhs: Element) {
        let rhs = removeLast()
        let lhs = removeLast()
        return (lhs: lhs, rhs: rhs)
    }
}

enum InfixOrNumeric {
    case infix([Token])
    case numeric(Int)
}

extension RangeReplaceableCollection {
    static func + (lhs: Element, rhs: Self) -> Self {
        return [lhs] + rhs
    }

    static func + (lhs: Self, rhs: Element) -> Self {
        return lhs + [rhs]
    }
}

/// Reverse Polish Notation
/// https://en.wikipedia.org/wiki/Reverse_Polish_notation
public class ReversePolishNotation {

    public static func solveEquation(_ equation: Equation) -> Solution {
        let reversePolish = reversePolishNotationFrom(infix: equation.infix)

        if reversePolish.contains(where: { $0.isUnsetVariable }) {
            // TODO this
            return .algebraic(equation)
        } else {
            return .numeric(
                solveNumeric(reversePolish.compactMap { OperandOrOperator(token: $0) })
            )
        }
    }

    private static func solveNumeric(_ tokens: [OperandOrOperator]) -> Int {
        var stack = [Int]()

        for token in tokens {
            switch token {
            case .operand(let operand):
                stack.append(operand)
            case .operator(let `operator`):
                let operands = stack.removeLastTwo()
                let function = `operator`.function
                stack.append(function(operands.lhs, operands.rhs))
            }
        }
        return stack.first ?? 0
    }

    static func toInfixFrom(rpn tokens: [OperandOrOperator]) -> [Token] {
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
                let op = Token(token)
                terms.append(.tokens(
                    ﹙ + lhs + op + rhs + ﹚
                    ))
            }
        }

        return terms.flatMap { $0.toTokens() }
    }


    /// https://en.wikipedia.org/wiki/Shunting-yard_algorithm
    public static func reversePolishNotationFrom(infix: [Token]) -> [Token] {
        var tokenStack = [Token]()
        var reversePolishNotation = [Token]()

        for token in infix {
            switch token {
            case .operand:
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
}
