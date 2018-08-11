//
//  MultiplicationNumberVariable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func *(lhs: Int, rhs: Variable) -> Expression {
    if lhs == 0 { return .number(0) } // TODO replace with nil
    if lhs == 1 { return .variable(rhs) }
    return .mul(int: lhs, `var`: rhs)
}

/// Multiplication is Commutative, lets set the standard to always be `2 * x`
func *(lhs: Variable, rhs: Int) -> Expression {
    return rhs * lhs // flipping because of Commutative and setting a `2 * x` convention
}
