//
//  Concatenating+Subtraction.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// Concatenate `lhs` and `rhs` using addition
public func -(lhs: Concatenating, rhs: Concatenating) -> Polynomial {
    return Polynomial(lhs).subtracting(other: Polynomial(rhs))
}

// MARK: - Numberic Support
public func -(lhs: Concatenating, rhs: Int) -> Polynomial {
    return Polynomial(lhs).subtracting(constant: rhs)
}
public func -(lhs: Int, rhs: Concatenating) -> Polynomial {
    return Polynomial(rhs).subtracting(constant: lhs)
}
public func -(lhs: Concatenating, rhs: Double) -> Polynomial {
    return Polynomial(lhs).subtracting(constant: rhs)
}
public func -(lhs: Double, rhs: Concatenating) -> Polynomial {
    return Polynomial(rhs).subtracting(constant: lhs)
}


// MARK: - Internal
internal func -<F>(lhs: Concatenating, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
    return Polynomial(lhs).subtracting(constant: rhs)
}

internal func -<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
    return Polynomial(lhs).subtracting(constant: rhs)
}

internal func -<F>(lhs: F, rhs: Concatenating) -> Polynomial where F: BinaryFloatingPoint {
    return Polynomial(rhs).negated() + lhs
}

internal func -<I>(lhs: I, rhs: Concatenating) -> Polynomial where I: BinaryInteger {
    return Polynomial(rhs).negated() + lhs
}

// MARK - Private Polynomial Extension
private extension Polynomial {

    func subtracting(other: Polynomial) -> Polynomial {
        return self + other.negated()
    }

    func subtracting<F>(constant: F) -> Polynomial where F: BinaryFloatingPoint {
        return Polynomial(terms: terms, constant: self.constant - Double(constant))
    }

    func subtracting<I>(constant: I) -> Polynomial where I: BinaryInteger {
        return Polynomial(terms: terms, constant: self.constant - Double(constant))
    }
}
