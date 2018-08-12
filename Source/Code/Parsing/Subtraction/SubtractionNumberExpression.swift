//
//  SubtractionNumberExpression.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Expression SUB Int
func -(lhs: Expression, rhs: Int) -> Expression {
    if rhs == 0 { return lhs }
    if rhs < 0 { return .add(exp: lhs, int: abs(rhs)) }
    return .sub(exp: lhs, int: rhs)
}

func -(lhs: Int, rhs: Expression) -> Expression {
    if lhs == 0 { return rhs.negated() }
    return .sub(int: lhs, exp: rhs)
}


