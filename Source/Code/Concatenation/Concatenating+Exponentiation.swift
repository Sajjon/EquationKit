//
//  Concatenating+Exponentiation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func ^^(lhs: Concatenating, rhs: Int) -> Polynomial {
    return Polynomial(lhs).raised(to: rhs)
}


// MARK: - Internal
internal func ^^<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
    return Polynomial(lhs).raised(to: rhs)
}


// MARK: - Polynomial
private extension Polynomial {
    func raised<I>(to exponent: I) -> Polynomial where I: BinaryInteger {
        var polynomialExponentiated: Polynomial = 1

        // base * base * base ... // exponent times
        for _ in 0..<Int(exponent) {
            polynomialExponentiated = polynomialExponentiated * self
        }
        return polynomialExponentiated
    }
}
