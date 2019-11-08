//
//  Double_Operators.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-25.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import EquationKit

public typealias Variable = VariableStruct<Double>
public typealias Constant = ConstantStruct<Double>
public typealias Polynomial = PolynomialType<Double>

public typealias Exponentiation = ExponentiationStruct<Double>
public typealias Term = TermStruct<Exponentiation>

public func +(lhs: Atom, rhs: Atom) -> PolynomialType<Double> {
    return Polynomial(lhs).adding(other: Polynomial(rhs))
}

public func +(lhs: Atom, rhs: Double) -> PolynomialType<Double> {
    return Polynomial(lhs).adding(constant: rhs)
}

public func +(lhs: Double, rhs: Atom) -> PolynomialType<Double> {
    return Polynomial(rhs).adding(constant: lhs)
}

public func -(lhs: Atom, rhs: Atom) -> PolynomialType<Double> {
    return Polynomial(lhs).subtracting(other: Polynomial(rhs))
}

public func -(lhs: Atom, rhs: Double) -> PolynomialType<Double> {
    return Polynomial(lhs).subtracting(constant: rhs)
}

public func -(lhs: Double, rhs: Atom) -> PolynomialType<Double> {
    return Polynomial(rhs).negated().adding(constant: lhs)
}

public func *(lhs: Atom, rhs: Atom) -> PolynomialType<Double> {
    return Polynomial(lhs).multipliedBy(other: Polynomial(rhs))
}

public func *(lhs: Atom, rhs: Double) -> PolynomialType<Double> {
    return Polynomial(lhs).multipliedBy(constant: rhs)
}

public func *(lhs: Double, rhs: Atom) -> PolynomialType<Double> {
    return rhs * lhs
}

public func ^^(lhs: Atom, rhs: Int) -> PolynomialType<Double> {
    return Polynomial(lhs).raised(to: rhs)
}
