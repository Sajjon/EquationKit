//
//  DivisionNumberExpression.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-12.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func /(numerator: Expression, denominator: Int) -> Expression {
    guard denominator != 0 else { fatalError("Cannot divide by 0") }
    guard denominator != 1 else { return numerator }
    guard denominator != -1 else { return numerator.negated() }
    return .div(exp: numerator, int: denominator)
}

func /(numerator: Int, denominator: Expression) -> Expression {
    guard numerator != 0 else { return .number(0) } // TODO: replace with `nil`
    return .div(int: numerator, exp: denominator)
}
