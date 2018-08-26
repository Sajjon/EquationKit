//
//  BigInt_Variables.swift
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

typealias Variable = VariableStruct<BigInt>
typealias Constant = ConstantStruct<BigInt>
typealias Polynomial = PolynomialType<BigInt>

typealias Exponentiation = ExponentiationStruct<BigInt>
typealias Term = TermStruct<Exponentiation>

let x = Variable("x")
let y = Variable("y")
let z = Variable("z")
let x² = Exponentiation(x, exponent: 2)
let x³ = Exponentiation(x, exponent: 3)
let x⁴ = Exponentiation(x, exponent: 4)
let x⁵ = Exponentiation(x, exponent: 5)
let x⁶ = Exponentiation(x, exponent: 6)
let x⁷ = Exponentiation(x, exponent: 7)
let x⁸ = Exponentiation(x, exponent: 8)
let x⁹ = Exponentiation(x, exponent: 9)

let y² = Exponentiation(y, exponent: 2)
let y³ = Exponentiation(y, exponent: 3)
let y⁴ = Exponentiation(y, exponent: 4)
let y⁵ = Exponentiation(y, exponent: 5)
let y⁶ = Exponentiation(y, exponent: 6)
let y⁷ = Exponentiation(y, exponent: 7)
let y⁸ = Exponentiation(y, exponent: 8)
let y⁹ = Exponentiation(y, exponent: 9)

let z² = Exponentiation(z, exponent: 2)
let z³ = Exponentiation(z, exponent: 3)
let z⁴ = Exponentiation(z, exponent: 4)
let z⁵ = Exponentiation(z, exponent: 5)
let z⁶ = Exponentiation(z, exponent: 6)
let z⁷ = Exponentiation(z, exponent: 7)
let z⁸ = Exponentiation(z, exponent: 8)
let z⁹ = Exponentiation(z, exponent: 9)

