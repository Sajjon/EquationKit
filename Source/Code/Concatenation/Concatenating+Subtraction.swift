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

private func -(lhs: Concatenating, rhs: Polynomial) -> Polynomial {
    return lhs - (rhs as Concatenating)
}

// MARK: - Numberic Support
public func -(lhs: Concatenating, rhs: Int) -> Polynomial {
    return lhs - Polynomial(constant: rhs)
}

public func -(lhs: Concatenating, rhs: Double) -> Polynomial {
    return lhs - Polynomial(constant: rhs)
}

public func -(lhs: Int, rhs: Concatenating) -> Polynomial {
    return Polynomial(constant:lhs) - rhs
}

public func -(lhs: Double, rhs: Concatenating) -> Polynomial {
    return Polynomial(constant:lhs) - rhs
}


//private func -<F>(lhs: Concatenating, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
//    return lhs - Polynomial(constant: rhs)
//}
//private func -<F>(lhs: F, rhs: Concatenating) -> Polynomial where F: BinaryFloatingPoint {
//    return Polynomial(constant:lhs) - rhs
//}
//
//private func -<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
//    return lhs - Polynomial(constant: rhs)
//}
//private func -<I>(lhs: I, rhs: Concatenating) -> Polynomial where I: BinaryInteger {
//    return Polynomial(constant:lhs) - rhs
//}


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
