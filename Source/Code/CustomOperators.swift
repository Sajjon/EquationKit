//
//  CustomOperators.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation


precedencegroup ExponentiationPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left
}

infix operator ^^: ExponentiationPrecedence
infix operator <-: AssignmentPrecedence

func <-(variable: Variable, value: Double) -> Constant {
    return Constant(variable, value: value)
}

func <-(variable: Variable, value: Int) -> Constant {
    return variable <- Double(value)
}

internal func += <N>(lhs: inout N?, rhs: N) where N: Numeric {
    if let lhsIndeed = lhs {
        lhs = lhsIndeed + rhs
    } else {
        lhs = rhs
    }
    if lhs == 0 {
        lhs = nil
    }
}
