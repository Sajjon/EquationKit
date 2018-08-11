//
//  BinaryOperator+Term+Differentiate.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public extension BinaryOperator {
    func differentate(lhs: Term, rhs: Term) -> Term {
        let infixOperation: InfixToken = .operator(.binary(self))
        let op: Term = .token(infixOperation)

        switch self {
        case .pow: return diffPow(lhs: lhs, rhs: rhs)
        case .add: if let res = diffAdd(lhs: lhs, rhs: rhs) { return res }
        case .sub: if let res = diffSub(lhs: lhs, rhs: rhs) { return res }
        default: break
        }

        let asTerms: [Term] = [.﹙, lhs, op, rhs, .﹚]
        return .tokens(asTerms.flatMap { $0.toTokens() })
    }
}

private extension BinaryOperator {
    func diffPow(lhs: Term, rhs: Term) -> Term {
        switch (lhs, rhs) {
        case (.token(let l), .token(let r)):
            guard let base = l.variable, let exponent = r.value else { fatalError() }

            let prefix: [InfixToken] = {
                let suffix: [InfixToken] = exponent > 1 ? [.c(exponent), .mul] : []
                return [﹙] + suffix
            }()

            let suffix: [InfixToken] = {
                let mid: [InfixToken] = exponent > 2 ? [.pow, .c(exponent-1)] : []
                return [.v(base)] + mid + [﹚]
            }()

            return .tokens(prefix + suffix)

        case (.tokens, .token(let r)):
            guard let exponent = r.value else { fatalError() }
            let asTerms: [Term] = [.﹙, .c(exponent), .mul, lhs, .pow, .c(exponent-1), .﹚]
            return .tokens(asTerms.flatMap { $0.toTokens() })

        default: fatalError()

        }
    }

    func diffAdditionOrSubtraction(_ lhs: Term, _ rhs: Term, op binaryOperator: BinaryOperator) -> Term? {
        let op: Term = .token(.operator(.binary(binaryOperator)))
        switch (lhs,  rhs) {
        case (.token(let l), .tokens):
            let const: Int
            guard let operand = l.asOperand() else { fatalError() }
            switch operand {
            case .constant: const = 0
            case .variable: const = 1
            }
            let asTerms: [Term] = [.﹙, .c(const), op, rhs, .﹚]
            return .tokens(asTerms.flatMap { $0.toTokens() })
        case (.tokens, .token(let r)):
            let const: Int
            guard let operand = r.asOperand() else { fatalError() }
            switch operand {
            case .constant: const = 0
            case .variable: const = 1
            }
            let asTerms: [Term] = [.﹙, lhs, op, .c(const) ,.﹚]
            return .tokens(asTerms.flatMap { $0.toTokens() })
        default: return nil
        }
    }

    func diffAdd(lhs: Term, rhs: Term) -> Term? {
        return diffAdditionOrSubtraction(lhs, rhs, op: .add)
    }

    func diffSub(lhs: Term, rhs: Term) -> Term? {
        return diffAdditionOrSubtraction(lhs, rhs, op: .sub)
    }
}
