//
//  Algebraic.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Algebraic: Solvable, Concatenating, Differentiatable, Hashable, CustomStringConvertible {
//    static func +(lhs: Self, rhs: Self) -> Polynomial<NumberType>
//    static func +(lhs: Self, rhs: NumberType) -> Polynomial<NumberType>
//    static func +(lhs: NumberType, rhs: Self) -> Polynomial<NumberType>

//    static func -(lhs: Self, rhs: Self) -> Polynomial<NumberType>
//    static func -(lhs: Self, rhs: NumberType) -> Polynomial<NumberType>
//    static func -(lhs: NumberType, rhs: Self) -> Polynomial<NumberType>

//    static func *(lhs: Self, rhs: Self) -> Polynomial<NumberType>
//    static func *(lhs: Self, rhs: NumberType) -> Polynomial<NumberType>
//    static func *(lhs: NumberType, rhs: Self) -> Polynomial<NumberType>

//    static func ^^(lhs: Self, rhs: Int) -> Polynomial<NumberType>
}
/*
public extension PolynomialProtocol {

    init<A>(a algebraic: A) where A: Algebraic {
        if let variable = algebraic as? VariableStruct<NumberType> {
            self.init(variable: variable)
        } else if let exponentiation = algebraic as? ExponentiationType {
            self.init(exponentiation: exponentiation, constant: NumberType.zero)
        } else if let term = algebraic as? TermType {
            self.init(term: term)
        } else if let polynomial = algebraic as? Self {
            self.init(terms: polynomial.terms, constant: polynomial.constant)
        } else {
            fatalError("unhandled, self.numbertype")
        }
    }
}


public extension Algebraic {
    static func +(lhs: Self, rhs: Self) -> Polynomial<NumberType> {
        return Polynomial(a: lhs) + Polynomial(a: rhs)
    }

//    static func +(lhs: Self, rhs: NumberType) -> Polynomial<NumberType> {
//        return Polynomial(a: lhs) + rhs
//    }
//
//    static func +(lhs: NumberType, rhs: Self) -> Polynomial<NumberType> {
//        return rhs + lhs // commutative
//    }

    static func -(lhs: Self, rhs: Self) -> Polynomial<NumberType> {
        return Polynomial(a: lhs) - Polynomial(a: rhs)
    }
//    static func -(lhs: Self, rhs: NumberType) -> Polynomial<NumberType> {
//        return Polynomial(a: lhs) - rhs
//    }
//    static func -(lhs: NumberType, rhs: Self) -> Polynomial<NumberType> {
//        return lhs - Polynomial(a: rhs)
//    }

    static func *(lhs: Self, rhs: Self) -> Polynomial<NumberType> {
        return Polynomial(a: lhs) * Polynomial(a: rhs)
    }
//    static func *(lhs: Self, rhs: NumberType) -> Polynomial<NumberType> {
//        return Polynomial(a: lhs) * rhs
//    }
//    static func *(lhs: NumberType, rhs: Self) -> Polynomial<NumberType> {
//        return rhs * lhs // commutative
//    }

    static func ^^(lhs: Self, rhs: Int) -> Polynomial<NumberType> {
        return Polynomial(a: lhs) ^^ rhs
    }
}
public extension PolynomialProtocol {

    // MARK: - Addition
    static func +(lhs: Self, rhs: Self) -> Polynomial<NumberType> {
        return Polynomial(a: lhs.adding(other: rhs))
    }
//    static func +(lhs: Self, rhs: NumberType) -> Polynomial<NumberType> {
//        return Polynomial(a: lhs.adding(constant: rhs))
//    }
//    // Addition is commutative
//    static func +(lhs: NumberType, rhs: Self) -> Polynomial<NumberType> {
//        return rhs + lhs
//    }

    // MARK: - Subtraction
    static func -(lhs: Self, rhs: Self) -> Polynomial<NumberType> {
        return Polynomial(a: lhs.subtracting(other: rhs))
    }

//    static func -(lhs: Self, rhs: NumberType) -> Polynomial<NumberType> {
//        return Polynomial(a: lhs.subtracting(constant: rhs))
//    }
//
//    static func -(lhs: NumberType, rhs: Self) -> Polynomial<NumberType> {
//        return Polynomial(a: rhs.negated().adding(constant: lhs))
//    }

    // MARK: - Multiplication
    static func *(lhs: Self, rhs: Self) -> Polynomial<NumberType> {
        return Polynomial(a: lhs.multipliedBy(other: rhs))
    }

//    static func *(lhs: Self, rhs: NumberType) -> Polynomial<NumberType> {
//        return Polynomial(a: lhs.multipliedBy(constant: rhs))
//    }
//
//    // Multiplication is commutative
//    static func *(lhs: NumberType, rhs: Self) -> Polynomial<NumberType> {
//        return rhs * lhs
//    }

    // Exponentiation
    static func ^^(lhs: Self, rhs: Int) -> Polynomial<NumberType> {
        return Polynomial(a: lhs.raised(to: rhs))
    }
}
*/
