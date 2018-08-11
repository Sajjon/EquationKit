//
//  Modulus.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

func mod<T>(_ number: T, modulus: T) -> T where T: BinaryInteger {
    var mod = number % modulus
    if mod < 0 {
        mod = mod + modulus
    }
    guard mod >= 0 else { fatalError("NEGATIVE VALUE") }
    return mod
}

func mod<T>(_ modulus: T, expression: () -> T) -> T where T: BinaryInteger {
    return mod(expression(), modulus: modulus)
}

func modInverse(mod p: Int, _ x: Int, _ y: Int) -> Int {
    let x = x > 0 ? x : x + p
    let y = y > 0 ? y : y + p
    let euclideanResult = extendedGreatestCommonDivisor(y, p)
    let inverse = euclideanResult.bézoutCoefficients.0
    return mod(p) { inverse * x }
}

