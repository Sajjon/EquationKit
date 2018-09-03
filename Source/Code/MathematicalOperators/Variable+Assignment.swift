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

//public func <-<N>(exponentiation: ExponentiationStruct<N>, poly: PolynomialType<N>) -> Substitution<N> where N: NumberExpressible {
//    return Substitution<N>(from: PolynomialType(exponentiation: exponentiation), to: poly)
//}

//public func <-<N>(exponentiation: ExponentiationStruct<N>, value: N) -> Substitution<N> where N: NumberExpressible {
//    return Substitution<N>(from: PolynomialType(exponentiation: exponentiation), to: PolynomialType(constant: value))
//}

public func <-<N>(variable: VariableStruct<N>, poly: PolynomialType<N>) -> Substitution<N> where N: NumberExpressible {
    return Substitution<N>(from: PolynomialType(variable: variable), to: poly)
}

public func <-<N>(from: PolynomialType<N>, to: PolynomialType<N>) -> Substitution<N> where N: NumberExpressible {
    return Substitution(from: from, to: to)
}


public func <-<N>(variable: VariableStruct<N>, value: N) -> Substitution<N> where N: NumberExpressible {
    return Substitution<N>(fromVariable: variable, to: value)
}

//public func <-<N>(variable: VariableStruct<N>, value: N) -> ConstantStruct<N> where N: NumberExpressible {
//    return ConstantStruct<N>(variable, value: value)
//}
public func ≔ <N>(variable: VariableStruct<N>, value: N) -> Substitution<N> {
    return variable <- PolynomialType<N>(constant: value)
}
