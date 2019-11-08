//
//  BigInt_Operators.swift
//  EquationKitBigIntTests
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import EquationKit

/// https://github.com/attaswift/BigInt
import BigInt

public typealias Variable = VariableStruct<BigInt>
public typealias Constant = ConstantStruct<BigInt>
public typealias Polynomial = PolynomialType<BigInt>

public typealias Exponentiation = ExponentiationStruct<BigInt>
public typealias Term = TermStruct<Exponentiation>

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

public func ^^(lhs: BigInt, rhs: Int) -> BigInt {
    return lhs.power(rhs)
}

public func ^^(lhs: Int, rhs: Int) -> BigInt {
    return BigInt(lhs) ^^ rhs
}

public func -(lhs: BigInt, rhs: Int) -> BigInt {
    return lhs - BigInt(rhs)
}
