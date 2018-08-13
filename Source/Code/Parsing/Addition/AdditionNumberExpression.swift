//
//  AdditionNumberExpression.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Expression ADD Int
func +(lhs: Expression, rhs: Int) -> Expression {
    if rhs == 0 { return lhs }
    if rhs < 0 { return .sub(exp: lhs, int: abs(rhs)) }
    return .add(exp: lhs, int: rhs)
}

/// Addition is Commutative, lets set the standard to always be `Expression + 1`
func +(lhs: Int, rhs: Expression) -> Expression {
    return rhs + lhs // flipping because of Commutative and setting a `Expression + 1` convention
}

func +(lhs: Expression, rhs: Variable) -> Expression {
    switch lhs {
    case .operand(let operand):
        switch operand {
        case .number(let number):
            // Addition is commutative, prefer `x+1` over `1+x`
            return rhs + number
        case .variable(let variable):
            return .add(`var`: variable, `var`: rhs)
        }
    case .operator(let `operator`):
        return .add(`var`: rhs, operator: `operator`)
    }
}
