//
//  Subtraction.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

protocol AdditionOrSubtraction {}

struct Sub: Operator, AdditionOrSubtraction {
    let lhs: Expression
    let rhs: Expression
    let wrapInParenthesis: Bool
    init(lhs: Expression, rhs: Expression, wrapInParenthesis: Bool) {
        guard !lhs.number.equals(0), !rhs.number.equals(0) else { fatalError("Should handle case where either term equals to 0 elsewhere") }
        self.lhs = lhs
        self.rhs = rhs
        self.wrapInParenthesis = wrapInParenthesis
    }
    
    static var function: Function { return { $0 - $1 } }
    var operatorString: String { return "-" }
}

extension Sub {

    func adding(number: Int) -> Expression {
        if let lhsNumber = lhs.number {
            return (lhsNumber + number) - rhs
        } else if let rhsNumber = rhs.number {
            return lhs - (rhsNumber - number)
        }
        return .add(operator: self, int: number)
    }

    func subtracting(number: Int) -> Expression {
        if let lhsNumber = lhs.number {
            return (lhsNumber - number) - rhs
        } else if let rhsNumber = rhs.number {
            return lhs - (rhsNumber + number)
        }
        return .sub(operator: self, int: number)
    }

    func subtractingThisOperatorFrom(number: Int) -> Expression {
        if let lhsNumber = lhs.number {
            return (number-lhsNumber) + rhs
        } else if let rhsNumber = rhs.number {
            return (number - rhsNumber) - lhs
        }
        return .sub(operator: self, int: number)
    }
}

extension Expression {

    /// Case 0: Int - Int
    static func sub(int lhs: Int, int rhs: Int) -> Expression {
        return .number(Sub.function(lhs, rhs))
    }

    /// Case 1: Variable - Variable
    /// TODO return Optional<Expression> and return `nil` for case `x -x` instead of returning 0
    static func sub(`var` lhs: Variable, `var` rhs: Variable) -> Expression {
        if lhs == rhs { // x - x  <==> 0
            return .number(0)
        } else {
            return .operator(Sub(`var`: lhs, `var`: rhs))
        }
    }

    /// Case 2: Variable - Int
    static func sub(`var` lhs: Variable, int rhs: Int) -> Expression {
        if rhs == 0 { return .variable(lhs) }
//        if rhs < 0 { return .add(`var`: lhs, int: abs(rhs)) }
        return .operator(Sub(`var`: lhs, int: rhs))
    }

    /// Case 3: Int - Variable
    /// Subtraction is NOT commutative, hence cannot reuse `Case 2`
    static func sub(int lhs: Int, `var` rhs: Variable) -> Expression {
        if lhs == 0 { return .variable(rhs) }
        return .operator(Sub(int: lhs, `var`: rhs))
    }

    /// Case 4: Operator - Int
    static func sub(`operator` lhs: Operator, int rhs: Int) -> Expression {
        if rhs == 0 { return .operator(lhs) }
//        if rhs < 0 { return .add(operator: lhs, int: abs(rhs)) }
        return .operator(Sub(operator: lhs, int: rhs, wrapInParenthesis: true))
    }

    /// Case 5: Int - Operator
    static func sub(int lhs: Int, `operator` rhs: Operator) -> Expression {
        if lhs == 0 { fatalError("return just rhs (Operator) Negated???") }
        return .operator(Sub(int: lhs, operator: rhs, wrapInParenthesis: true))
    }

    /// Case 6: Expression - Int
    static func sub(exp lhs: Expression, int rhs: Int) -> Expression {
        if rhs == 0 { return lhs }
//        if rhs < 0 { return .add(exp: lhs, int: abs(rhs)) }

        if let lhsNumber = lhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .sub(int: lhsNumber, int: rhs)
        } else if let lhsVariable = lhs.variable {
            return .sub(`var`: lhsVariable, int: rhs)
        } else if let `operator` = lhs.asOperator() {
            return `operator`.subtracting(number: rhs)
        } else { fatalError("this should not happend") }
    }

    /// Case 7: Int - Expression
    /// Note: Subtraction is not commutative, making the need for this
    static func sub(int lhs: Int, exp rhs: Expression) -> Expression {
        if lhs == 0 { fatalError("return just rhs NEGATED?") }
        if let rhsNumber = rhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .sub(int: lhs, int: rhsNumber)
        } else if let rhsVariable = rhs.variable {
            return .sub(int: lhs, `var`: rhsVariable)
        } else if let `operator` = rhs.asOperator() {
            return `operator`.subtractingThisOperatorFrom(number: lhs)
        } else { fatalError("this should not happend") }
    }
}
