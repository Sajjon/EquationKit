//
//  DivisionNumberVariable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func /(numerator: Int, denominator: Variable) -> Expression {
    if numerator == 0 { return .number(0) } // TODO replace with nil
    return .div(int: numerator, `var`: denominator)
}

func /(numerator: Variable, denominator: Int) -> Expression {
    guard denominator != 0 else { fatalError("Cannot divide by 0") }
    guard denominator != 1 else { return .variable(numerator) }
    return .div(`var`: numerator, int: denominator)
}
