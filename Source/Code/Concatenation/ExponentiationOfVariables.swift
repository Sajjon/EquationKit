//
//  ExponentiationOfVariables.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK - Base Variable
public func ^^(base: Variable, exponent: Double) -> Term {
    return Term(exponentiation: Exponentiation(base, exponent: exponent))
}

public func ^^(base: Variable, exponent: Int) -> Term {
    return base ^^ Double(exponent)
}

// MARK - Base Term
public func ^^(base: Term, exponent: Double) -> Term {
    return base.multiplyingExponent(by: exponent)
}

public func ^^(base: Term, exponent: Int) -> Term {
    return base ^^ Double(exponent)
}

// MARK - Base Polynomial, exponent Integer
public func ^^ (base: Polynomial, exponent: Int) -> Polynomial {
    var polynomialExponentiated: Polynomial = 1

    // base * base * base ... // exponent times
    for _ in 0..<exponent {
        polynomialExponentiated = polynomialExponentiated * base
    }
    return polynomialExponentiated
}
