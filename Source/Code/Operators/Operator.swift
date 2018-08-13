//
//  Operator.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

protocol Operator: CustomStringConvertible, CustomDebugStringConvertible, Differentiatable, Negatable {

    func equals(other: Operator) -> Bool
    var isCommutative: Bool { get }

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

    // Operator ^ EXP
    func exponentiatedBy(exponent: Int) -> Expression
    // EXP ^ Operatpr
    func exponentiating(base: Int) -> Expression
}

extension Operator {
    func negated() -> Self {
        return Self.init(lhs: lhs.negated(), rhs: rhs.negated())
    }
}

extension Add {
    var isCommutative: Bool { return true }
}
extension Mul {
    var isCommutative: Bool { return true }
}
extension Operator {
    var isCommutative: Bool { return false }
}

/// Like `Equatable`, but cannot use it because it constrains the code
extension Operator {
    func equals(other: Operator) -> Bool {
        func operandsEquals() -> Bool {
            if isCommutative {
                return (lhs.equals(other: other.lhs) && rhs.equals(other: other.rhs)) ||
                (lhs.equals(other: other.rhs) && rhs.equals(other: other.lhs))
            } else {
                return lhs.equals(other: other.lhs) && rhs.equals(other: other.rhs)
            }
        }
        return operatorString == other.operatorString && operandsEquals()
    }


}

extension Operator {
    init(lhs: Expression, rhs: Expression) {
        self.init(lhs: lhs, rhs: rhs, wrapInParenthesis: false)
    }
}

extension Operator {
    var function: Function { return Self.function }
    func differentiated(withRespectTo variable: Variable) -> Expression {
        return .operator(self)
    }
}

extension Add {
    // Example, differentiate w.r.t. `x`
    // x + 2 => 1
    // y + 2 => y
    // x + y => y + 1
    // x + x => 2
    // y + z => UNCHANGED
    func differentiated(withRespectTo variable: Variable) -> Expression {
        // Addition is commutative, dont care if variable is rhs or lhs...
        if let (_, `var`) = numberAndVariable {
            guard `var` == variable else {
                // y + 2 => y
                return .variable(`var`)
            }
            return .number(1)
        } else if let lhsVar = lhs.variable, let rhsVar = rhs.variable {
            if lhsVar == variable && rhsVar == variable { // lhsVar == rhsVar: x + x
                return .number(2)
            } else if lhsVar == variable {
                // x + y => 1 + y => y + 1
                return rhsVar + 1
            } else if rhsVar == variable {
                // y + x => y + 1
                return lhsVar + 1
            } else {
                // y + z: Unchanged
                return .operator(self)
            }
        }
        // else (number, number)
        return .number(0) // TODO replace with `nil`
    }
}

extension Sub {
    // Example, differentiate w.r.t. `x`
    // x - 2 => 1
    // y - 2 => y
    // 2 - x => -1
    // 2 - y => -y
    // x - y => 1 - y
    // x - x => 0 (should have been handled earlier..?)
    // y - z => UNCHANGED
    // 1 - 2 => nil // TODO fix nil, for now `0`
    func differentiated(withRespectTo variable: Variable) -> Expression {
        if let lhsVar = lhs.variable {
            if lhsVar == variable {
                // x - 2 => 1
                return .number(1)
            } else {
                // y - 2 => y
                return .variable(lhsVar)
            }
        } else if let rhsVar = rhs.variable {
            if rhsVar == variable {
                // 2 - x
                return .number(-1)
            } else {
                // 2 - y => -y
                return .variable(rhsVar.negated())
            }
        } else if let lhsVar = lhs.variable, let rhsVar = rhs.variable {
            if lhsVar == variable && rhsVar == variable { // lhsVar == rhsVar: x - x
                return .number(0)
            } else if lhsVar == variable {
                // x - y => 1 - y
                return 1 - rhsVar
            } else if rhsVar == variable {
                // y - x => y - 1
                return lhsVar - 1
            } else {
                // y - z: Unchanged
                return .operator(self)
            }
        } else if let lhsOperator = lhs.asOperator(), let rhsOperator = rhs.asOperator() {
            return lhsOperator.differentiated(withRespectTo: variable) - rhsOperator.differentiated(withRespectTo: variable)
        } else if let lhsOperator = lhs.asOperator(), let rhsOperand = rhs.asOperand() {
            return lhsOperator.differentiated(withRespectTo: variable) - rhsOperand.differentiated(withRespectTo: variable)
        } else if let lhsOperand = lhs.asOperand(), let rhsOperator = rhs.asOperator() {
            return lhsOperand.differentiated(withRespectTo: variable) - rhsOperator.differentiated(withRespectTo: variable)
        }
        // else (number, number)
        return .number(0) // TODO replace with `nil`
    }
}

extension Expression {
    func asOperand() -> Operand? {
        switch self {
        case .operand(let operand): return operand
        case .operator: return nil
        }
    }
}

extension Mul {
    // Example, differentiate w.r.t. `x`
    // x * 2 => 2
    // y * 2 => UNCHANGED
    // x * y => y
    // x * x => 2
    // y * z => UNCHANGED
    func differentiated(withRespectTo variable: Variable) -> Expression {
        // Multiplication is commutative, dont care if variable is rhs or lhs...
        if let (num, `var`) = numberAndVariable {
            guard `var` == variable else {
                // y * 2
                return .operator(self)
            }
            // x * 9 => 9
            return .number(num)
        } else if let lhsVar = lhs.variable, let rhsVar = rhs.variable {
            if lhsVar == variable && rhsVar == variable { // lhsVar == rhsVar: x + x
                // x * x
                return .number(2)
            } else if lhsVar == variable {
                // x * y => y
                return rhs
            } else if rhsVar == variable {
                // y * x => y
                return rhs
            } else {
                // y * z: Unchanged
                return .operator(self)
            }
        }
        // else (number, number)
        return .number(0) // TODO replace with `nil`
    }
}

extension Pow {
    // Example, differentiate w.r.t. `x`
    // x ^ 2 => 2x
    // x ^ 3 => 3x^2
    // y ^ 2 => UNCHANGED
    // x ^ y => y*x^(y-1)
    // y ^ z => UNCHANGED
    // differentiating x where x is exponent is NOT SUPPORTED yet
      // 2 ^ x => 2^x log(2) (NOT SUPPORTED YET)
      // y ^ x => y^x log(y) (NOT SUPPORTED YET)
      // x ^ x => x^x (log(x) + 1) (NOT SUPPORTED YET)
    func differentiated(withRespectTo variable: Variable) -> Expression {
        if let baseAsVariable = base.variable {
            if baseAsVariable == variable {
                // x ^ 3 => 3x^2
                // or
                // x ^ z => z*x^(z-1)
                return exponent * (baseAsVariable ^ (exponent - 1))
            } else {
                // y ^ 3 => UNCHANGED
                return .operator(self)
            }
        } else if let exponentAsVariable = exponent.variable {
            if exponentAsVariable == variable {
                fatalError("not supported yet")
            } else {
                // 3 ^ y => unchanged
                // or
                // z ^ y => unchanged
                return .operator(self)
            }
        }
        // else (number, number)
        return .number(0) // TODO replace with `nil`
    }
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

    func exponentiatedBy(exponent: Int) -> Expression {
        return .pow(operator: self, int: exponent)
    }

    func exponentiating(base: Int) -> Expression {
        return .pow(int: base, operator: self)
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

    init(`var` lhs: Variable, `operator` rhs: Operator, wrapInParenthesis: Bool = false) {
        self.init(lhs: .variable(lhs), rhs: .operator(rhs), wrapInParenthesis: wrapInParenthesis)
    }

    init(`operator` lhs: Operator, `operator` rhs: Operator, wrapInParenthesis: Bool = false) {
        self.init(lhs: .operator(lhs), rhs: .operator(rhs), wrapInParenthesis: wrapInParenthesis)
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

    var varVar: (lhs: Variable, rhs: Variable)? {
        guard let lhsVar = lhs.variable, let rhsVar = rhs.variable else {
            return nil
        }
        return (lhs: lhsVar, rhs: rhsVar)
    }
}
