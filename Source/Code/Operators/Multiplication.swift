//
//  Multiplication.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

struct Mul: Operator {
    let lhs: Expression
    let rhs: Expression
    let wrapInParenthesis: Bool
    init(lhs: Expression, rhs: Expression, wrapInParenthesis: Bool) {
        guard !lhs.number.equals(0), !rhs.number.equals(0) else { fatalError("Should handle case where either term equals to 0 elsewhere") }
        self.lhs = lhs
        self.rhs = rhs
        self.wrapInParenthesis = wrapInParenthesis
    }
    
    static var function: Function { return { $0 * $1 } }
    var operatorString: String { return "*" }
}

extension Mul {
    /// Example:  (3 * x) * 5  <==>  (15 * x)
    func multiplied(by number: Int) -> Expression {
        if let lhsNumber = lhs.number {
            return function(lhsNumber, number) * rhs
        } else if let rhsNumber = rhs.number {
            return function(rhsNumber, number) * lhs
        } else {
            print("💣 adding two Expressions, should this have been handled elsewhere???")
            return .mul(operator: self, int: number)
        }
    }
}

extension Expression {

    /// Case 0 - Int * Int
    /// TODO: Return `nil` instead of `number(0)` when multiplying with 0
    static func mul(int lhs: Int, int rhs: Int) -> Expression {
        return .number(Mul.function(lhs, rhs))
    }

    /// Case 1 - Variable * Variable
    /// TODO when POW replace x*x with pow(x, 2)
    static func mul(`var` lhs: Variable, `var` rhs: Variable) -> Expression {
        /* if lhs == rhs { return .pow(2, lhs) } */
        return .operator(Mul(`var`: lhs, `var`: rhs))
    }

    /// Case 2 - Int * Variable
     public static func mul(int lhs: Int, `var` rhs: Variable) -> Expression {
        return case2Mul(int: lhs, `var`: rhs)
    }
    internal static func case2Mul(int lhs: Int, `var` rhs: Variable) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with `nil`
        if lhs == 1 { return .variable(rhs) }
        /* if rhs > 0 && rhs < 1 { return .div(`var`: lhs, int: 1/rhs ) } */ //TODO when Decimals
        return .operator(Mul(int: lhs, `var`: rhs))
    }


    /// Case 3 - Variable * Int (Commutative version of Case 2)
    public static func mul(`var` lhs: Variable, int rhs: Int) -> Expression {
        return case2Mul(int: rhs, `var`: lhs)
    }

   /// Case 4 - Operator * Int
    static func mul(`operator` lhs: Operator, int rhs: Int) -> Expression {
        if rhs == 0 { return .number(0) } // TODO replace with `nil`
        if rhs == 1 { return .operator(lhs) }
        return .operator(Mul(operator: lhs, int: rhs, wrapInParenthesis: true))
    }

    /// Case 5 - Int * Expression
    static func mul(int lhs: Int, exp rhs: Expression) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with `nil`
        if lhs == 1 { return rhs }

        if let rhsNumber = rhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .mul(int: rhsNumber, int: lhs)
        } else if let rhsVariable = rhs.variable {
            // Multiplication is commutative, lets enforce `3 * x` standard, as opposed to `x * 3`, by placing number first.
            return .mul(int: lhs, `var`: rhsVariable)
        } else if let `operator` = rhs.asOperator() {
            return `operator`.multiplied(by: lhs)
        } else { fatalError("this should not happend") }
    }

}
