//
//  Operator.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

protocol Operator: CustomStringConvertible, CustomDebugStringConvertible {

    var operatorString: String { get }
    var lhs: Expression { get }
    var rhs: Expression { get }
    var wrapInParenthesis: Bool { get }
    init(lhs: Expression, rhs: Expression, wrapInParenthesis: Bool)
    typealias Function = (Int, Int) -> Int
    static var function: Function { get }

    /// Caller called `self + Int`, where `self` is an instance of this Operator and `Int` is some integer. We need to "merge" this operator with the integer. Below is a table of what is expected to happen for the most common four operators:
    func adding(number: Int) -> Expression

    /// `Operator - A`, where `A` == `number` in argument
    func subtracting(number: Int) -> Expression
    /// `A - Operator`, where `A` == `number` in argument
    func subtractingThisOperatorFrom(number: Int) -> Expression

    func multiplied(by number: Int) -> Expression

    // (x + 4) / 3
    func divided(by number: Int) -> Expression
    // 3 / (x + 4)
    func dividingNumberByThisOperator(_ number: Int) -> Expression
}


extension Operator {
    init(lhs: Expression, rhs: Expression) {
        self.init(lhs: lhs, rhs: rhs, wrapInParenthesis: false)
    }
}

extension Operator {
    var function: Function { return Self.function }
}

extension Operator {
    func adding(number: Int) -> Expression {
        return .add(operator: self, int: number)
    }

    func subtracting(number: Int) -> Expression {
        return .sub(operator: self, int: number)
    }

    func subtractingThisOperatorFrom(number: Int) -> Expression {
        return .sub(int: number, operator: self)
    }

    func multiplied(by number: Int) -> Expression {
        return .mul(operator: self, int: number)
    }

    func divided(by number: Int) -> Expression {
        return .div(operator: self, int: number)
    }

    func dividingNumberByThisOperator(_ number: Int) -> Expression {
        return .div(int: number, operator: self)
    }
}

extension Operator {

    init(operand lhs: Operand, operand rhs: Operand, wrapInParenthesis: Bool = false) {
        guard !(lhs.isNumber && rhs.isNumber) else { fatalError("Should take care of this case somewhere else...") }
        self.init(lhs: .operand(lhs), rhs: .operand(rhs), wrapInParenthesis: wrapInParenthesis)
    }

    init(int lhs: Int, `var` rhs: Variable, wrapInParenthesis: Bool = false) {
        self.init(lhs: .number(lhs), rhs: .variable(rhs), wrapInParenthesis: wrapInParenthesis)
    }

    init(`var` lhs: Variable, `var` rhs: Variable, wrapInParenthesis: Bool = false) {
        self.init(lhs: .variable(lhs), rhs: .variable(rhs), wrapInParenthesis: wrapInParenthesis)
    }

    init(`var` lhs: Variable, int rhs: Int, wrapInParenthesis: Bool = false) {
        self.init(lhs: .variable(lhs), rhs: .number(rhs), wrapInParenthesis: wrapInParenthesis)
    }

    init(`operator` lhs: Operator, int rhs: Int, wrapInParenthesis: Bool = false) {
        self.init(lhs: .operator(lhs), rhs: .number(rhs), wrapInParenthesis: wrapInParenthesis)
    }

    init(int lhs: Int, `operator` rhs: Operator, wrapInParenthesis: Bool = false) {
        self.init(lhs: .number(lhs), rhs: .operator(rhs), wrapInParenthesis: wrapInParenthesis)
    }
}

func printName<T>(_ instance: T) -> String {
    return "\(type(of: instance))"
}

extension Operator {
    var description: String {
        let string = "\(lhs) \(operatorString) \(rhs)"
        guard wrapInParenthesis else { return string }
        return "(\(string))"
    }

    var debugDescription: String {
        func operandDescription(_ expression: Expression) -> String {
            guard let `operator` = expression.asOperator() else {
                return expression.description
            }
            return `operator`.debugDescription
        }
        return "\(printName(self))(\(operandDescription(lhs)), \(operandDescription(rhs)))"
    }
}

extension Operator {
    var lhsNumberRhsExp: (lhs: Int, rhs: Expression)? {
        switch (lhs, rhs) {
        case (.operand(.number), .operand(.number)): fatalError("should not happen")
        case (.operand(.number(let number)), _): return (lhs: number, rhs: rhs)
        default: return nil
        }
    }

    var lhsExpRhsNumber: (lhs: Expression, rhs: Int)? {
        switch (lhs, rhs) {
        case (.operand(.number), .operand(.number)): fatalError("should not happen")
        case (_, .operand(.number(let number))): return (lhs: lhs, rhs: number)
        default: return nil
        }
    }

    var lhsNumberRhsVar: (lhs: Int, rhs: Variable)? {
        guard let number = lhs.number, let variable = rhs.variable else { return nil }
        return (lhs: number, rhs: variable)
    }

    var lhsVarRhsNumber: (lhs: Variable, rhs: Int)? {
        guard let variable = lhs.variable, let number = rhs.number else { return nil }
        return (lhs: variable, rhs: number)
    }

    var numberAndVariable: (number: Int, variable: Variable)? {
        if let lnrv = lhsNumberRhsVar {
            return (number: lnrv.lhs, variable: lnrv.rhs)
        } else if let lvrn = lhsVarRhsNumber {
             return (number: lvrn.rhs, variable: lvrn.lhs)
        }
        return nil
    }
}
