//
//  ExtendedEuclideanAlgorithm.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

struct ExtendedEuclideanAlgorithmResult<T: BinaryInteger> {

    /// Greatest Common Divisor
    let gcd: T
    let bézoutCoefficients: (T, T)
    let quotientsByTheGCD: (T, T)
}

/// https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm
func extendedGreatestCommonDivisor<T: BinaryInteger>(_ a: T, _ b: T) -> ExtendedEuclideanAlgorithmResult<T> {

    var s: T = 0
    var oldS: T = 1

    var t: T = 1
    var oldT: T = 0

    var r: T = b
    var oldR: T = a

    while r != 0 {
        let q = oldR.quotientAndRemainder(dividingBy: r).quotient
        (oldR, r) = (r, oldR - q * r)
        (oldS, s) = (s, oldS - q * s)
        (oldT, t) = (t, oldT - q * t)

    }
    let bézoutCoefficients = (oldS, oldT)
    let gcd = oldR
    let quotientsByTheGCD = (t, s)
    return ExtendedEuclideanAlgorithmResult(
        gcd: gcd,
        bézoutCoefficients: bézoutCoefficients,
        quotientsByTheGCD: quotientsByTheGCD
    )
}
