//
//  MultiplicationNumberExpression.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Expression MUL Int
func *(lhs: Int, rhs: Expression) -> Expression {
    if lhs == 0 { return .number(0) } // TODO replace with nil
    if lhs == 1 { return rhs }
    return .mul(int: lhs, exp: rhs)
}

/// Multiplication is Commutative, lets set the standard to always be `Expression + 1`
func *(lhs: Expression, rhs: Int) -> Expression {
    return rhs * lhs // flipping because of Commutative and setting a `Expression + 1` convention
}

func *(lhs: Variable, rhs: Expression) -> Expression {
    switch rhs {
    case .operand(let operand):
        switch operand {
        case .number(let number):
            // Multiplication is commutative, prefer `2x` over `x2`
            return number * lhs
        case .variable(let variable):
            return .mul(`var`: lhs, `var`: variable)
        }
    case .operator(let `operator`):
        return .mul(`var`: lhs, operator: `operator`)
    }
}

func *(lhs: Expression, rhs: Variable) -> Expression {
    switch lhs {
    case .operand(let operand):
        switch operand {
        case .number(let number):
            // Multiplication is commutative, prefer `2x` over `x2`
            return number * rhs
        case .variable(let variable):
            return .mul(`var`: variable, `var`: rhs)
        }
    case .operator(let `operator`):
        return .mul(`var`: rhs, operator: `operator`)
    }
}
