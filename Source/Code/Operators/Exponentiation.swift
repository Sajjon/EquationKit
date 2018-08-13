//
//  Exponentiation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-12.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation


precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator ** : ExponentiationPrecedence

private func ** (base: Int, exponent: Int) -> Int {
    return Int(pow(Double(base), Double(exponent)))
}


struct Pow: Operator {
    let lhs: Expression
    let rhs: Expression
    let wrapInParenthesis: Bool
    init(lhs: Expression, rhs: Expression, wrapInParenthesis: Bool) {
        guard !lhs.number.equals(0), !rhs.number.equals(0) else { fatalError("Should handle case where either term equals to 0 elsewhere") }
        self.lhs = lhs
        self.rhs = rhs
        self.wrapInParenthesis = wrapInParenthesis
    }

    static var function: Function { return { $0 ** $1 } }
    var operatorString: String { return "^" }
}

extension Pow {
    var base: Expression {
        return lhs
    }

    var exponent: Expression {
        return rhs
    }
}

extension Operator {
    func hasAtLeastOneCommonVariable(with other: Operator) -> Bool {
        if let rhsVar = rhs.variable {
            return other.contains(variable: rhsVar)
        } else if let lhsVar = lhs.variable {
            return other.contains(variable: lhsVar)
        }
        return false
    }
}

func -(lhs: Operator, rhs: Operator) -> Expression {
    guard !lhs.equals(other: rhs) else { // e.g. (x^3) - (x^3)
        // replace this with nil
        return .number(0)
    }
    if lhs.hasAtLeastOneCommonVariable(with: rhs) {
        fatalError("do smart stuff")
    }
    return .operator(Sub(operator: lhs, operator: rhs))
}

func +(lhs: Variable, rhs: Variable) -> Expression {
    if lhs == rhs { return 2 * lhs }
    return .add(`var`: lhs, `var`: rhs)
}

func +(lhs: Operand, rhs: Operand) -> Expression {
    switch (lhs, rhs) {
    case (.number(let lhsNum), .number(let rhsNum)): return .add(int: lhsNum, int: rhsNum)
    case (.variable(let lhsVar), .variable(let rhsVar)): return .add(`var`: lhsVar, `var`: rhsVar)
    case (.variable(let lhsVar), .number(let rhsNum)): return .add(`var`: lhsVar, int: rhsNum)
    case (.number(let lhsNum), .variable(let rhsVar)): return .add(int: lhsNum, `var`: rhsVar)
    }
}

func -(lhs: Operand, rhs: Operand) -> Expression {
    switch (lhs, rhs) {
    case (.number(let lhsNum), .number(let rhsNum)): return .sub(int: lhsNum, int: rhsNum)
    case (.variable(let lhsVar), .variable(let rhsVar)): return .sub(`var`: lhsVar, `var`: rhsVar)
    case (.variable(let lhsVar), .number(let rhsNum)): return .sub(`var`: lhsVar, int: rhsNum)
    case (.number(let lhsNum), .variable(let rhsVar)): return .sub(int: lhsNum, `var`: rhsVar)
    }
}

func +(lhs: Operator, rhs: Operator) -> Expression {
    guard !lhs.equals(other: rhs) else { // e.g. (x^3) + (x^3)
        return .mul(int: 2, operator: lhs)
    }

    if let additionLHS = lhs as? Add {
        if let additionRHS = rhs as? Add {
            if let (lhsNum, lhsVar) = additionLHS.numberAndVariable, let (rhsNum, rhsVar) = additionRHS.numberAndVariable {
                return (lhsVar + rhsVar) + (lhsNum+rhsNum)
            } else if let (lhsNum, lhsVar) = additionLHS.numberAndVariable, let (rhsVarLhs, rhsVarRhs) = additionRHS.varVar {

                if lhsVar == rhsVarLhs {
                    // (x+2) + (x+y) => (2x+y) + 2
                    return ((2 * lhsVar) + rhsVarRhs) + lhsNum
                } else if lhsVar == rhsVarRhs {
                    // (x+2) + (y+x) => (2x+y) + 2
                    return ((2 * lhsVar) + rhsVarLhs) + lhsNum
                } else {
                    // (x+2) + (y+z) => UNCHANGED
                    return .operator(Add(operator: lhs, operator: rhs, wrapInParenthesis: false))
                }
            } else if let (lhsVarLhs, lhsVarRhs) = additionLHS.varVar, let (rhsNum, rhsVar) = additionRHS.numberAndVariable {
                fatalError("analogue to above")
            }
        } else if let subtractionRHS = rhs as? Sub {
            fatalError("somewhat analogue to above")
        }
    } else if let subtractionLHS = lhs as? Sub {
        fatalError("bah")
    }
    return .operator(Add(operator: lhs, operator: rhs))
}

func +(lhs: Expression, rhs: Expression) -> Expression {
    switch (lhs, rhs) {
    case (.operator(let lhsOperator), .operator(let rhsOperator)):
        return lhsOperator + rhsOperator
    case (.operator(let lhsOperator), .operand(let rhsOperand)):
        switch rhsOperand {
        case .number(let rhsNum): return .add(operator: lhsOperator, int: rhsNum)
        case .variable(let rhsvariable): return .add(`var`: rhsvariable, operator: lhsOperator)
        }
    case (.operand(let lhsOperand), .operator(let rhsOperator)):
        switch lhsOperand {
        case .number(let lhsNum): return .add(operator: rhsOperator, int: lhsNum)
        case .variable(let lhsVariable): return .add(`var`: lhsVariable, operator: rhsOperator)
        }
    case (.operand(let lhsOperand), .operand(let rhsOperand)):
        return lhsOperand + rhsOperand
    }
}


func -(lhs: Expression, rhs: Expression) -> Expression {
    switch (lhs, rhs) {
    case (.operator(let lhsOperator), .operator(let rhsOperator)):
        return lhsOperator - rhsOperator
    case (.operator(let lhsOperator), .operand(let rhsOperand)):
        switch rhsOperand {
        case .number(let rhsNum): return .sub(operator: lhsOperator, int: rhsNum)
        case .variable(let rhsvariable): return .sub(operator: lhsOperator, `var`: rhsvariable)
        }
    case (.operand(let lhsOperand), .operator(let rhsOperator)):
        switch lhsOperand {
        case .number(let lhsNum): return .sub(int: lhsNum, operator: rhsOperator)
        case .variable(let lhsVariable): return .sub(`var`: lhsVariable, operator: rhsOperator)
        }
    case (.operand(let lhsOperand), .operand(let rhsOperand)):
        return lhsOperand - rhsOperand
    }
}



//func ^(base: Pow, exponent: Pow) -> Expression {
//fatalError()
//}
//
//func ^(base: Operator, exponent: Operator) -> Expression {
//    if let basePow = base as? Pow, let expPow = exponent as? Pow {
//        return basePow ^ expPow
//    }
//    fatalError()
//}
//
//
//func ^(base: Expression, exponent: Expression) -> Expression {
//    switch (base, exponent) {
//    case (.operator(let lhsOperator), .operator(let rhsOperator)):
//        return lhsOperator ^ rhsOperator
//    case (.operator(let lhsOperator), .operand(let lhsOperand)):
//        if let fo = lhsOperator.lhsExpRhsNumber {
//
//        }
//    case (.operand(let lhsOperand), .operator(let rhsOperator)):
//    case (.operand(let lhsOperand), .operand(let lhsOperand)):
//    }
//}

extension Pow {
    func exponentiatedBy(exponent: Int) -> Expression {
//        return base ^ (exponent * self.exponent)
        fatalError()
    }

    func exponentiating(base: Int) -> Expression {
        return .pow(int: base, operator: self)
    }

    func divided(by number: Int) -> Expression {
        let lazyFallback: () -> Expression = { .div(operator: self, int: number) }

        guard let base = base.number, base == number else {
            return lazyFallback()
        }
        if let exponent = exponent.number {
             if exponent == 1 {
                // (2^1)/2 => 2^0 => 1
                return .number(1)
            } else if exponent == 2 {
                // (2^2)/2 => 2^1 => 2
                return .number(base)
            }
            return .number(Pow.function(base, exponent - 1))
        } else if let exponent = exponent.variable {
            // (2^x)/2 => Pow(2, Sub(x, 1)) <=> 2^(x-1)
            return base ^ (exponent - 1)
        }
        return lazyFallback()
    }

    func dividingNumberByThisOperator(_ number: Int) -> Expression {
        let lazyFallback: () -> Expression = { .div(int: number, operator: self) }

        guard let base = base.number, base == number else {
            return lazyFallback()
        }
        //    2 / (2^3)
        if let exponent = exponent.number {
            if exponent == 1 {
                // 2/(2^1) => 1/2^0 => 1/1 => 1
                return .number(1)
            } else if exponent == 2 {
                // 2/(2^2) => 1/2^1 => 1/2
                fatalError("Should return 1/2, but we dont support decimals yet...")
            }
            // 2/2^5
            fatalError("Should return `1/(base ^ (exponent - 1))` here, but we dont support decimals yet")
        } else if let exponent = exponent.variable {
            // 2/(2^x) => Div(1, Pow(base, exp-1) <=> 1/(2^(x-1))
            return 1 / (base ^ (exponent - 1))
        }
        return lazyFallback()
    }

    func multiplied(by number: Int) -> Expression {
        let lazyFallback: () -> Expression = { .mul(operator: self, int: number) }

        guard let base = base.number, base == number else {
            return lazyFallback()
        }


        if let exponent = exponent.number {
            // (2^3) * 2 => 2^4
            if exponent == -1 {
                // 2^-1 * 2 => 2^0 => 1
                return .number(1)
            }
            return .number(Pow.function(base, exponent+1))
        } else if let exponent = exponent.variable {
            // (2^x) * 2 => 2^(x+1)
            return base ^ (exponent + 1)
        }

        return lazyFallback()
    }

}

extension Expression {

    /// Case 0: Int ^ Int
    static func pow(int lhs: Int, int rhs: Int) -> Expression {
        return .number(Pow.function(lhs, rhs))
    }

    /// Case 1: Variable - Variable
    static func pow(`var` lhs: Variable, `var` rhs: Variable) -> Expression {
        return .operator(Pow(`var`: lhs, `var`: rhs))
    }

    /// Case 2 - Int ^ Variable
    static func pow(int lhs: Int, `var` rhs: Variable) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with nil
        if lhs == 1 { return .number(1) }
        return .operator(Pow(int: lhs, `var`: rhs))
    }

    /// Case 3 - Variable ^ Int
    static func pow(`var` lhs: Variable, int rhs: Int) -> Expression {
        return .operator(Pow(`var`: lhs, int: rhs))
    }

    /// Case 4: Operator - Int
    static func pow(`operator` lhs: Operator, int rhs: Int) -> Expression {
        if rhs == 0 { return .number(1) }
        if rhs == 1 { return .operator(lhs) }
        return .operator(Pow(operator: lhs, int: rhs, wrapInParenthesis: true))
    }

    /// Case 5: Int - Operator
    static func pow(int lhs: Int, `operator` rhs: Operator) -> Expression {
        if lhs == 0 { return .number(0) }
        if lhs == 1 { return .number(1) }
        return .operator(Pow(int: lhs, operator: rhs, wrapInParenthesis: true))
    }

    /// Case 6: Expression ^ Int
    static func pow(exp lhs: Expression, int rhs: Int) -> Expression {
        if rhs == 0 { return .number(1) }
        if rhs == 1 { return lhs }

        if let lhsNumber = lhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .pow(int: lhsNumber, int: rhs)
        } else if let lhsVariable = lhs.variable {
            return .pow(`var`: lhsVariable, int: rhs)
        } else if let `operator` = lhs.asOperator() {
            return `operator`.exponentiatedBy(exponent: rhs)
        } else { fatalError("this should not happend") }
    }

    /// Case 7: Int ^ Expression
    static func pow(int lhs: Int, exp rhs: Expression) -> Expression {
        if lhs == 0 { return .number(0) }
        if lhs == 1 { return .number(1) }

        if let rhsNumber = rhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .pow(int: lhs, int: rhsNumber)
        } else if let rhsVariable = rhs.variable {
            return .pow(int: lhs, `var`: rhsVariable)
        } else if let `operator` = rhs.asOperator() {
            return `operator`.exponentiating(base: lhs)
        } else { fatalError("this should not happend") }
    }
}
