//
//  Concatenating+Addition.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func +(lhs: Concatenating, rhs: Concatenating) -> Polynomial {
    return Polynomial(lhs).appending(polynomial: Polynomial(rhs))
}

// MARK: - Numberic Support
public func +<F>(lhs: Concatenating, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
    return Polynomial(lhs).appending(constant: rhs)
}

public func +<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
    return Polynomial(lhs).appending(constant: rhs)
}

// MARK: - Multiplication is commutative
public func +<F>(lhs: F, rhs: Concatenating) -> Polynomial where F: BinaryFloatingPoint {
    return rhs + lhs
}

public func +<I>(lhs: I, rhs: Concatenating) -> Polynomial where I: BinaryInteger {
    return rhs + lhs
}

// MARK - Appending
private extension Polynomial {

    func appending<F>(constant: F) -> Polynomial where F: BinaryFloatingPoint {
        return Polynomial(terms: terms, constant: self.constant + Double(constant))
    }

    func appending<I>(constant: I) -> Polynomial where I: BinaryInteger {
        return appending(constant: Double(constant))
    }

    func appending(polynomial other: Polynomial) -> Polynomial {
        return Polynomial(terms: terms + other.terms, constant: constant + other.constant)
    }
}
