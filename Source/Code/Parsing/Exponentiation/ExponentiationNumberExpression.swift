//
//  ExponentiationNumberExpression.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-12.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func ^(lhs: Expression, rhs: Int) -> Expression {
    if rhs == 0 { return .number(1) }
    if rhs == 1 { return lhs }
    if rhs == -1 { return .div(int: 1, exp: lhs) }
    if rhs < -1 { return .div(int: 1, exp: (lhs ^ abs(rhs))) }
    return .pow(exp: lhs, int: rhs)
}


func ^(lhs: Int, rhs: Expression) -> Expression {
    if lhs == 0 { return .number(0) } // TODO replace with nil
    if lhs == 1 { return .number(1) }
    return .pow(int: lhs, exp: rhs)
}


func ^(base: Variable, exponent: Expression) -> Expression {
    fatalError()
}

