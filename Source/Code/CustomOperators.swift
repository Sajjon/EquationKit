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

public func <-<N>(variable: VariableStruct<N>, value: N) -> ConstantStruct<N> where N: NumberExpressible {
    return ConstantStruct<N>(variable: variable, value: value)
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
