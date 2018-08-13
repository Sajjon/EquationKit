//
//  Division.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

struct Div: Operator {
    let lhs: Expression
    let rhs: Expression
    let wrapInParenthesis: Bool
    init(lhs: Expression, rhs: Expression, wrapInParenthesis: Bool) {
        guard !lhs.number.equals(0), !rhs.number.equals(0) else { fatalError("Should handle case where either term equals to 0 elsewhere") }
        self.lhs = lhs
        self.rhs = rhs
        self.wrapInParenthesis = wrapInParenthesis
    }

    static var function: Function { return { $0 / $1 } }
    var operatorString: String { return "/" }
}

extension Div {
    var numerator: Expression {
        return lhs
    }

    var denominator: Expression {
        return rhs
    }
}

extension Div {
    func divided(by number: Int) -> Expression {
        if let numerator = numerator.number, let denominator = denominator.variable {
            // Example: 10/x
            let gcd = extendedGreatestCommonDivisor(numerator, number).gcd
            if gcd == 1 { // `Div(10, x) / 3` ==> `Div(10, Mul(3, x)`
                let _multiplication = Mul(int: number, `var`: denominator)
                let _division = Div(int: numerator, operator: _multiplication, wrapInParenthesis: true)
                return .operator(_division)
            } else { // `Div(10, x) / 5` ==> `Div(2, x)`
                let newNumerator = numerator/gcd
                return newNumerator / denominator
            }
        } else if let numerator = numerator.variable, let denominator = denominator.number {
            // Example: `Div(x, 10) / 5` ==> `Div(x, 50)`
            let newDenominator = denominator * number
            return numerator / newDenominator
        }
        fatalError("which case did I miss?")
    }

    func dividingNumberByThisOperator(_ number: Int) -> Expression {
        return .div(int: number, operator: self)
    }

    func multiplied(by number: Int) -> Expression {
        fatalError("do this")
    }
}


extension Expression {

    /// Case 0: Int / Int
    static func div(int lhs: Int, int rhs: Int) -> Expression {
        return .number(Div.function(lhs, rhs))
    }

    /// Case 1: Variable / Variable
    static func div(`var` lhs: Variable, `var` rhs: Variable) -> Expression {
        if lhs == rhs { return .number(1) } /* x/x => 1 */
        return .operator(Div(`var`: lhs, `var`: rhs))
    }

    /// Case 2: Variable / Int
    static func div(`var` lhs: Variable, int rhs: Int) -> Expression {
        if rhs == 0 { fatalError("CANNOT DIVIDE BY ZERO") }
        if rhs == 1 { return .variable(lhs) }
        return .operator(Div(`var`: lhs, int: rhs))
    }

    /// Case 3: Variable / Int
    /// Note: Division is NOT Commutative, thus cannot use flipped version of Case 2
    static func div(int lhs: Int, `var` rhs: Variable) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with `nil`
        return .operator(Div(int: lhs, `var`: rhs))
    }

    /// Case 4: Operator / Int
    static func div(`operator` lhs: Operator, int rhs: Int) -> Expression {
        guard rhs != 0 else { fatalError("division by zero") }
        if rhs == 1 { return .operator(lhs) }
        return .operator(Div(operator: lhs, int: rhs, wrapInParenthesis: true))
    }

    /// Case 5: Int / Operator
    static func div(int lhs: Int, `operator` rhs: Operator) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with `nil`
        return .operator(Div(int: lhs, operator: rhs, wrapInParenthesis: true))
    }

    /// Case 6: Int / Expression
    static func div(int lhs: Int, exp rhs: Expression) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with `nil`

        if let rhsNumber = rhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .div(int: rhsNumber, int: lhs)
        } else if let rhsVariable = rhs.variable {
            return .div(`var`: rhsVariable, int: lhs)
        } else if let `operator` = rhs.asOperator() {
            return `operator`.dividingNumberByThisOperator(lhs)
        } else { fatalError("this should not happend") }
    }

    /// Case 7: Expression / Int
    static func div(exp lhs: Expression, int rhs: Int) -> Expression {
        guard rhs != 0 else { fatalError("division by 0") }

        if let lhsNumber = lhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .div(int: lhsNumber, int: rhs)
        } else if let lhsVariable = lhs.variable {
            return .div(`var`: lhsVariable, int: rhs)
        } else if let `operator` = lhs.asOperator() {
            return `operator`.divided(by: rhs)
        } else { fatalError("this should not happend") }
    }
}
