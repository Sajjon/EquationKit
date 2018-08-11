//
//  Addition.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation


struct Add: Operator, AdditionOrSubtraction {
    let lhs: Expression
    let rhs: Expression
    let wrapInParenthesis: Bool
    init(lhs: Expression, rhs: Expression, wrapInParenthesis: Bool) {
        guard !lhs.number.equals(0), !rhs.number.equals(0) else { fatalError("Should handle case where either term equals to 0 elsewhere") }
        self.lhs = lhs
        self.rhs = rhs
        self.wrapInParenthesis = wrapInParenthesis
    }

    static var function: Function { return { $0 + $1 } }
    var operatorString: String { return "+" }
}


extension Expression {

    /// Case 0 - Int + Int
    static func add(int lhs: Int, int rhs: Int) -> Expression {
        return .number(Add.function(lhs, rhs))
    }

    /// Case 1 - Variable + Variable
    static func add(`var` lhs: Variable, `var` rhs: Variable) -> Expression {
        if lhs == rhs { return .mul(int: 2, `var`: lhs) }
        return .operator(Add(`var`: lhs, `var`: rhs))
    }

    /// Case 2 - Variable + Int
    public static func add(`var` lhs: Variable, int rhs: Int) -> Expression {
        return case2Add(`var`: lhs, int: rhs)
    }
    internal static func case2Add(`var` lhs: Variable, int rhs: Int) -> Expression {
        if rhs == 0 { return .variable(lhs) }
        if rhs < 0 { return .sub(`var`: lhs, int: abs(rhs)) }
        return .operator(Add(`var`: lhs, int: rhs))
    }

    /// Case 3 - Int + Variable (Commutative version of Case 2)
    static func add(int lhs: Int, `var` rhs: Variable) -> Expression {
        return case2Add(`var`: rhs, int: lhs)
    }

    /// Case 4 - Operator + Int
    static func add(`operator` lhs: Operator, int rhs: Int) -> Expression {
        if rhs == 0 { return .operator(lhs) }
        if rhs < 0 { return .sub(operator: lhs, int: abs(rhs)) }
        return .operator(Add(operator: lhs, int: rhs, wrapInParenthesis: true))
    }

    /// Case 5 - Expression + Int
    /// Using Case 5 of Subtraction if `rhs` is negative
    static func add(exp lhs: Expression, int rhs: Int) -> Expression {
        if rhs == 0 { return lhs }
        if rhs < 0 { return .sub(exp: lhs, int: abs(rhs)) }

        if let lhsNumber = lhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .add(int: lhsNumber, int: rhs)
        } else if let lhsVariable = lhs.variable {
            return .add(`var`: lhsVariable, int: rhs)
        } else if let `operator` = lhs.asOperator() {
            return `operator`.adding(number: rhs)
        } else { fatalError("this should not happend") }
    }
}

extension Add {

    /// Case - result ==0: `(x + 3) + (-3)` => `Variable(x)` <==> `x`
    /// Case - result  <0: `(x + 3) + (-4)` => `Sub(x, 1)`   <==> `x - 1`
    /// Case - result  >0: `(x + 3) + 1`    => `Add(x, 4)`   <==> `x + 4`
    func adding(number: Int) -> Expression {
        func combineNumber(_ selfNumber: Int) -> Int {
         // `number` is on the right hand side, since calling this method is `someOperator.adding(number: A)` for any integer `A`. `selfNumber` refers to this operators rhs OR lhs, whichever was as number (if any, otherwise handled elsewhere in this function). This is important for non commuative operations such as Subtraction
            return function(selfNumber, number)
        }

        if let lhsNumber = lhs.number {
            return combineNumber(lhsNumber) + rhs
        } else if let rhsNumber = rhs.number {
            return lhs + combineNumber(rhsNumber)
        } else {
            print("💣 adding two Expressions, should this have been handled elsewhere???")
            return .add(operator: self, int: number)
        }
    }
}

//extension Sub {
//
//    /// Case - result ==0: `(x - 3) + 3` => `Variable(x)` <==> `x`
//    /// Case - result  <0: `(x - 3) + 4` => `Add(x, 1)`   <==> `x + 1`
//    /// Case - result  >0: `(x - 3) + 1` => `Sub(x, 2)`   <==> `x - 2`
//    func adding(number: Int) -> Expression {
//        func combineNumber(_ selfNumber: Int) -> Int {
//            // `number` is on the right hand side, since calling this method is `someOperator.adding(number: A)` for any integer `A`.
//            return function(selfNumber, number)
//        }
//
//        if let lhsNumber = lhs.number {
//            return combineNumber(lhsNumber) + rhs
//        } else if let rhsNumber = rhs.number {
//            return lhs + combineNumber(rhsNumber)
//        } else {
//            print("💣 adding two Expressions, should this have been handled elsewhere???")
//            return .add(self, number)
//        }
//    }
//}
