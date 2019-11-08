//
//  Variable+Assignment.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

infix operator <-: AssignmentPrecedence
infix operator ≔: AssignmentPrecedence

public func <-<N>(variable: VariableStruct<N>, value: N) -> ConstantStruct<N> where N: NumberExpressible {
    return ConstantStruct<N>(variable, value: value)
}
public func ≔ <N>(variable: VariableStruct<N>, value: N) -> ConstantStruct<N> {
    return variable <- value
}
