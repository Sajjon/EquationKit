//
//  Double_Operators.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-25.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// Do not include this line when you copy the contents of this file to your own project
@testable import EquationKit // This is only included since this file is used by EquationKitDoubleTests

public func +(lhs: Concatenating, rhs: Concatenating) -> PolynomialType<Double> {
    return Polynomial(lhs).adding(other: Polynomial(rhs))
}

public func +(lhs: Concatenating, rhs: Double) -> PolynomialType<Double> {
    return Polynomial(lhs).adding(constant: rhs)
}

public func +(lhs: Double, rhs: Concatenating) -> PolynomialType<Double> {
    return Polynomial(rhs).adding(constant: lhs)
}

public func -(lhs: Concatenating, rhs: Concatenating) -> PolynomialType<Double> {
    return Polynomial(lhs).subtracting(other: Polynomial(rhs))
}

public func -(lhs: Concatenating, rhs: Double) -> PolynomialType<Double> {
    return Polynomial(lhs).subtracting(constant: rhs)
}

public func -(lhs: Double, rhs: Concatenating) -> PolynomialType<Double> {
    return Polynomial(rhs).negated().adding(constant: lhs)
}

public func *(lhs: Concatenating, rhs: Concatenating) -> PolynomialType<Double> {
    return Polynomial(lhs).multipliedBy(other: Polynomial(rhs))
}

public func *(lhs: Concatenating, rhs: Double) -> PolynomialType<Double> {
    return Polynomial(lhs).multipliedBy(constant: rhs)
}

public func *(lhs: Double, rhs: Concatenating) -> PolynomialType<Double> {
    return rhs * lhs
}

public func ^^(lhs: Concatenating, rhs: Int) -> PolynomialType<Double> {
    return Polynomial(lhs).raised(to: rhs)
}
