//
//  DoubleTestsBase.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

public func +(lhs: Concatenating, rhs: Concatenating) -> Polynomial<Double> {
    return Polynomial(lhs).adding(other: Polynomial(rhs))
}
public func +(lhs: Concatenating, rhs: Double) -> Polynomial<Double> {
    return Polynomial(lhs).adding(constant: rhs)
}
public func +(lhs: Double, rhs: Concatenating) -> Polynomial<Double> {
    return Polynomial(rhs).adding(constant: lhs)
}
public func -(lhs: Concatenating, rhs: Concatenating) -> Polynomial<Double> {
    return Polynomial(lhs).subtracting(other: Polynomial(rhs))
}
public func -(lhs: Concatenating, rhs: Double) -> Polynomial<Double> {
    return Polynomial(lhs).subtracting(constant: rhs)
}
public func -(lhs: Double, rhs: Concatenating) -> Polynomial<Double> {
    return Polynomial(rhs).negated().adding(constant: lhs)
}
public func *(lhs: Concatenating, rhs: Concatenating) -> Polynomial<Double> {
    return Polynomial(lhs).multipliedBy(other: Polynomial(rhs))
}
public func *(lhs: Concatenating, rhs: Double) -> Polynomial<Double> {
    return Polynomial(lhs).multipliedBy(constant: rhs)
}
public func *(lhs: Double, rhs: Concatenating) -> Polynomial<Double> {
    return rhs * lhs
}

public func ^^(lhs: Concatenating, rhs: Int) -> Polynomial<Double> {
    return Polynomial(lhs).raised(to: rhs)
}

class DoubleTestsBase: XCTestCase {

    typealias Variable = VariableStruct<Double>
    typealias Constant = ConstantStruct<Double>
    typealias Exponentiation = ExponentiationStruct<Double>
    typealias Term = TermStruct<Exponentiation>
    typealias Eq = Polynomial<Double>

    lazy var x = Variable("x")
    lazy var y = Variable("y")
    lazy var z = Variable("z")
    lazy var x² = Exponentiation(x, exponent: 2)
    lazy var x³ = Exponentiation(x, exponent: 3)
    lazy var x⁴ = Exponentiation(x, exponent: 4)
    lazy var x⁵ = Exponentiation(x, exponent: 5)
    lazy var x⁶ = Exponentiation(x, exponent: 6)
    lazy var x⁷ = Exponentiation(x, exponent: 7)
    lazy var x⁸ = Exponentiation(x, exponent: 8)
    lazy var x⁹ = Exponentiation(x, exponent: 9)

    lazy var y² = Exponentiation(y, exponent: 2)
    lazy var y³ = Exponentiation(y, exponent: 3)
    lazy var y⁴ = Exponentiation(y, exponent: 4)
    lazy var y⁵ = Exponentiation(y, exponent: 5)
    lazy var y⁶ = Exponentiation(y, exponent: 6)
    lazy var y⁷ = Exponentiation(y, exponent: 7)
    lazy var y⁸ = Exponentiation(y, exponent: 8)
    lazy var y⁹ = Exponentiation(y, exponent: 9)

    lazy var z² = Exponentiation(z, exponent: 2)
    lazy var z³ = Exponentiation(z, exponent: 3)
    lazy var z⁴ = Exponentiation(z, exponent: 4)
    lazy var z⁵ = Exponentiation(z, exponent: 5)
    lazy var z⁶ = Exponentiation(z, exponent: 6)
    lazy var z⁷ = Exponentiation(z, exponent: 7)
    lazy var z⁸ = Exponentiation(z, exponent: 8)
    lazy var z⁹ = Exponentiation(z, exponent: 9)


    lazy var tx = Term(x)
    lazy var －tx = tx.negated()

    lazy var ty = Term(y)
    lazy var －ty = ty.negated()

    lazy var tz = Term(z)
    lazy var －tz = tz.negated()

    lazy var tx² = Term(exponentiation: x²)
    lazy var －tx² = tx².negated()

    lazy var ty² = Term(exponentiation: y²)
    lazy var －ty² = ty².negated()

    lazy var tz² = Term(exponentiation: z²)
    lazy var －tz² = tz².negated()

    lazy var tx³ = Term(exponentiation: x³)
    lazy var －tx³ = tx³.negated()

    lazy var ty³ = Term(exponentiation: y³)
    lazy var －ty³ = ty³.negated()

    lazy var tz³ = Term(exponentiation: z³)
    lazy var －tz³ = tz³.negated()

    lazy var tx⁴ = Term(x⁴)

    lazy var txyz = Term(x, y, z)
    lazy var －txyz = txyz.negated()

    lazy var txy = Term(x, y)
    lazy var －txy = txy.negated()
    lazy var txz = Term(x, z)
    lazy var －txz = txz
    lazy var tx²z³ = Term(x², z³)
    lazy var －tx²z³ = tx²z³.negated()
    lazy var tx²y²z² = Term(x², y², z²)
    lazy var －tx²y²z² = tx²y²z².negated()
    lazy var tx²y²z³ = Term(x²,y²,z³)
    lazy var －tx²y²z³ = tx²y²z³.negated()

}
