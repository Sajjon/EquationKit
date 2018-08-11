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
