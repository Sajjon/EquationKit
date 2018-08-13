//
//  ExponentiationNumberVariable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-12.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func ^(lhs: Int, rhs: Variable) -> Expression {
    if lhs == 0 { return .number(0) } // TODO replace with nil
    if lhs == 1 { return .number(1) }
    return .pow(int: lhs, `var`: rhs)
}

func ^(lhs: Variable, rhs: Int) -> Expression {
    if rhs == 0 { return .number(1) }
    if rhs == 1 { return .variable(lhs) }
    if rhs == -1 { return .div(int: 1, `var`: lhs) }
    if rhs < -1 { return .div(int: 1, exp: (lhs ^ abs(rhs))) }
    return .pow(`var`: lhs, int: rhs)
}
