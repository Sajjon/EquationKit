//
//  ConcatenatingByAddition.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol ConcatenatingByAddition: Concatenating {

    static func +<F>(lhs: Self, rhs: F) -> Polynomial where F: BinaryFloatingPoint

    static func +<I>(lhs: Self, rhs: I) -> Polynomial where I: BinaryInteger

    static func +(lhs: Self, rhs: Variable) -> Polynomial

    static func +(lhs: Self, rhs: Exponentiation) -> Polynomial

    static func +(lhs: Self, rhs: Term) -> Polynomial

    static func +(lhs: Self, rhs: Polynomial) -> Polynomial

}

// MARK: - Addition is commutative
public extension ConcatenatingByAddition {

    static func +<F>(lhs: F, rhs: Self) -> Polynomial where F: BinaryFloatingPoint {
        return rhs + lhs
    }

    static func +<I>(lhs: I, rhs: Self) -> Polynomial where I: BinaryInteger {
        return rhs + lhs
    }

    static func +(lhs: Variable, rhs: Self) -> Polynomial {
        return rhs + lhs
    }

    static func +(lhs: Exponentiation, rhs: Self) -> Polynomial {
        return rhs + lhs
    }

    static func +(lhs: Term, rhs: Self) -> Polynomial {
        return rhs + lhs
    }

    static func +(lhs: Polynomial, rhs: Self) -> Polynomial {
        return rhs + lhs
    }
}


// MARK: - Default Implementations
public extension ConcatenatingByAddition {

    static func +(lhs: Self, rhs: Variable) -> Polynomial {
        return Polynomial(lhs).appending(variable: rhs)
    }

    static func +<F>(lhs: Self, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
        return Polynomial(lhs).appending(constant: rhs)
    }

    static func +<I>(lhs: Self, rhs: I) -> Polynomial where I: BinaryInteger {
        return Polynomial(lhs).appending(constant: rhs)
    }

    static func +(lhs: Self, rhs: Exponentiation) -> Polynomial {
        return Polynomial(lhs).appending(exponentiation: rhs)
    }

    static func +(lhs: Self, rhs: Term) -> Polynomial {
        return Polynomial(lhs).appending(term: rhs)
    }

    static func +(lhs: Self, rhs: Polynomial) -> Polynomial {
        return Polynomial(lhs).appending(polynomial: rhs)
    }

}

// MARK: - Conformance - Variable
extension Variable: ConcatenatingByAddition {}
public extension Variable {
    static func +(lhs: Variable, rhs: Variable) -> Polynomial {
        return Polynomial(lhs).appending(variable: rhs)
    }
    
    func asVariable() -> Variable? { return self }
}

// MARK: - Conformance - Exponentiation
extension Exponentiation: ConcatenatingByAddition {}
public extension Exponentiation {
    static func +(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
        return Polynomial(lhs).appending(exponentiation: rhs)
    }

    func asExponentiation() -> Exponentiation? { return self }
}

// MARK: - Conformance - Term
extension Term: ConcatenatingByAddition {}
public extension Term {
    static func +(lhs: Term, rhs: Term) -> Polynomial {
        return Polynomial(lhs).appending(term: rhs)
    }

    func asTerm() -> Term? { return self }
}

// MARK: - Conformance - Polynomial
extension Polynomial: ConcatenatingByAddition {}
public extension Polynomial {
    static func +(lhs: Polynomial, rhs: Polynomial) -> Polynomial {
        return lhs.appending(polynomial: rhs)
    }

    func asPolynomial() -> Polynomial? { return self }
}
