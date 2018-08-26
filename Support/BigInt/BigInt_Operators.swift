//
//  BigInt_Operators.swift
//  EquationKitBigIntTests
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// https://github.com/attaswift/BigInt
import BigInt

// Do not include this line when you copy the contents of this file to your own project
@testable import EquationKit // This is only included since this file is used by EquationKitBigIntTests

public func +(lhs: Atom, rhs: Atom) -> PolynomialType<BigInt> {
    return Polynomial(lhs).adding(other: Polynomial(rhs))
}

public func +(lhs: Atom, rhs: BigInt) -> PolynomialType<BigInt> {
    return Polynomial(lhs).adding(constant: rhs)
}

public func +(lhs: BigInt, rhs: Atom) -> PolynomialType<BigInt> {
    return Polynomial(rhs).adding(constant: lhs)
}

public func -(lhs: Atom, rhs: Atom) -> PolynomialType<BigInt> {
    return Polynomial(lhs).subtracting(other: Polynomial(rhs))
}

public func -(lhs: Atom, rhs: BigInt) -> PolynomialType<BigInt> {
    return Polynomial(lhs).subtracting(constant: rhs)
}

public func -(lhs: BigInt, rhs: Atom) -> PolynomialType<BigInt> {
    return Polynomial(rhs).negated().adding(constant: lhs)
}

public func *(lhs: Atom, rhs: Atom) -> PolynomialType<BigInt> {
    return Polynomial(lhs).multipliedBy(other: Polynomial(rhs))
}

public func *(lhs: Atom, rhs: BigInt) -> PolynomialType<BigInt> {
    return Polynomial(lhs).multipliedBy(constant: rhs)
}

public func *(lhs: BigInt, rhs: Atom) -> PolynomialType<BigInt> {
    return rhs * lhs
}

public func ^^(lhs: Atom, rhs: Int) -> PolynomialType<BigInt> {
    return Polynomial(lhs).raised(to: rhs)
}
