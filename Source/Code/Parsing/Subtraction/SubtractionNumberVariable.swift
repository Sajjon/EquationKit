//
//  SubtractionNumberVariable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func -(lhs: Variable, rhs: Int) -> Expression {
    if rhs == 0 { return .variable(lhs) }
    if rhs < 0 {
        // Flipping `lhs` and `rhs` is OK since Addition is Commutative
        return .add(`var`: lhs, int: abs(rhs))
    }
    return .sub(`var`: lhs, int: rhs)
}

func -(lhs: Int, rhs: Variable) -> Expression {
    if lhs == 0 { return .variable(rhs) }
    return .sub(int: lhs, `var`: rhs)
}
