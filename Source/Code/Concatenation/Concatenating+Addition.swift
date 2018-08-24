//
//  Concatenating+Addition.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public typealias Polynomial = PolynomialStruct<Double>

///// Concatenate `lhs` and `rhs` using addition
public func +(lhs: Concatenating, rhs: Concatenating) -> Polynomial {
    return Polynomial(lhs).appending(polynomial: Polynomial(rhs))
}

// MARK: - Numberic Support
public func +(lhs: Concatenating, rhs: Int) -> Polynomial {
    return Polynomial(lhs).appending(constant: rhs)
}

public func +(lhs: Concatenating, rhs: Double) -> Polynomial {
    return Polynomial(lhs).appending(constant: rhs)
}
public func +(lhs: Double, rhs: Concatenating) -> Polynomial {
    return rhs + lhs

}
public func +(lhs: Int, rhs: Concatenating) -> Polynomial {
    return rhs + lhs

}

/////// Concatenate `lhs` and `rhs` using addition
//public func +<N>(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<N> {
//    return PolynomialStruct<N>(lhs) + PolynomialStruct<N>(rhs)
//}
//
//// MARK: - Numberic Support
//public func +<N>(lhs: Concatenating, rhs: Int) -> PolynomialStruct<N> {
//    return PolynomialStruct<N>(lhs) + rhs
//}
//
//public func +<N>(lhs: Concatenating, rhs: Double) -> PolynomialStruct<N> {
//    return PolynomialStruct<N>(lhs) + rhs
//}
//public func +<N>(lhs: Double, rhs: Concatenating) -> PolynomialStruct<N> {
//    return lhs + PolynomialStruct<N>(rhs)
//}
//public func +<N>(lhs: Int, rhs: Concatenating) -> PolynomialStruct<N> {
//    return lhs + PolynomialStruct<N>(rhs)
//}


// MARK - Polynomial Extension
public extension PolynomialProtocol {

    func appending<F>(constant: F) -> Self where F: BinaryFloatingPoint {
        return Self.init(terms: terms, constant: self.constant + NumberType(constant))
    }

    func appending<I>(constant: I) -> Self where I: BinaryInteger {
        return appending(constant: Double(constant))
    }

    func appending(polynomial other: Self) -> Self {
        return Self(terms: terms + other.terms, constant: constant + other.constant)
    }
}

private extension PolynomialProtocol {
    static func + (lhs: Self, rhs: Self) -> Self {
        return lhs.appending(polynomial: rhs)
    }

    static func + (lhs: Self, rhs: Int) -> Self {
        return lhs.appending(constant: rhs)
    }
    // addition is commutative
    static func + (lhs: Int, rhs: Self) -> Self {
        return rhs + lhs
    }

    static func + (lhs: Self, rhs: Double) -> Self {
        return lhs.appending(constant: rhs)
    }
    static func + (lhs: Double, rhs: Self) -> Self {
        return rhs + lhs
    }
}


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

// MARK - Private Polynomial Extension
private extension PolynomialProtocol {

    func subtracting(other: Self) -> Self {
        return self + other.negated()
    }

    func subtracting<F>(constant: F) -> Self where F: BinaryFloatingPoint {
        return Self(terms: terms, constant: self.constant - NumberType(constant))
    }

    func subtracting<I>(constant: I) -> Self where I: BinaryInteger {
        return Self(terms: terms, constant: self.constant - NumberType(constant))
    }
}
