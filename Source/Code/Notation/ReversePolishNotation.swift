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

extension Term {
    var asVariable: Variable? {
        switch self {
        case .token(let token): return token.variable
        default: return nil
        }
    }

    var asConstant: Int? {
        switch self {
        case .token(let token): return token.value
        default: return nil
        }
    }
}

extension InfixToken {
    static func c(_ x: Int) -> InfixToken {
        return .operand(.constant(x))
    }

    static func v(_ x: Variable) -> InfixToken {
        return .operand(.variable(x))
    }
}

extension Term {
    static func c(_ x: Int) -> Term {
        return .token(.c(x))
    }

    static func v(_ x: Variable) -> Term {
        return .token(.v(x))
    }
}

// MARK: - EquationRepresentation
extension ReversePolishNotation: EquationRepresentation {}
public extension ReversePolishNotation {


    func differentiate() -> Equation {
        var terms = [Term]()

        for token in tokens {
            switch token {
            case .operand(let operand):
                let term: Term = .token(.operand(operand))
                terms.append(term)
            case .operator(let `operator`):
                guard terms.count >= `operator`.arity else { fatalError("too few operands") }
                guard let binary = `operator`.asBinary else { fatalError("not supported")  }
                let rhs = terms.removeLast()
                let lhs = terms.removeLast()
                let differentiated = binary.differentate(lhs: lhs, rhs: rhs)
                terms.append(differentiated)
            }
        }
        var infixTokens = terms.flatMap { $0.toTokens() }
        if infixTokens.count > 1, infixTokens.first!.isLeftParenthesis && infixTokens.last!.isRightParenthesis {
            infixTokens.removeFirst()
            infixTokens.removeLast()
        }
        return Equation(infix: infixTokens)
    }

    func toReversePolishNotation() -> ReversePolishNotation {
        return self
    }

    func solveNumeric() -> Int? {
        var stack = [Int]()

        for token in tokens {
            switch token {
            case .operand(let operand):
                guard let value = operand.value else { fatalError("no numeric") }
                stack.append(value)
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
                let term: Term = .token(.operand(operand))
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
