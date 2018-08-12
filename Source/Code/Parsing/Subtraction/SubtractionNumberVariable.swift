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
        let rhsNegated = abs(rhs)
        if lhs.isNegative {
            return .sub(int: rhsNegated, `var`: lhs.negated())
        } else {
            // Flipping `lhs` and `rhs` is OK since Addition is Commutative
            return .add(`var`: lhs, int: rhsNegated)
        }
    }
    if lhs.isNegative { // -x + 1 => Sub(1, x)
        return .sub(int: -rhs, `var`: lhs.negated())
    }
    return .sub(`var`: lhs, int: rhs)
}

func -(lhs: Int, rhs: Variable) -> Expression {
    if lhs == 0 { return .variable(rhs.negated()) }
    if rhs.isNegative { return .add(`var`: rhs.negated(), int: lhs) }
    return .sub(int: lhs, `var`: rhs)
}

prefix func -(variable: Variable) -> Variable {
    return variable.negated()
}
