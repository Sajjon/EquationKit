//
//  AdditionNumberVariable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func +(lhs: Variable, rhs: Int) -> Expression {
    if rhs == 0 { return .variable(lhs) }
    if rhs < 0 { return .sub(`var`: lhs, int: abs(rhs)) }
    return .add(`var`: lhs, int: rhs)
}

/// Addition is Commutative, lets set the standard to always be `x + 1`
func +(lhs: Int, rhs: Variable) -> Expression {
    return rhs + lhs // flipping because of Commutative and setting a `x + 1` convention
}

