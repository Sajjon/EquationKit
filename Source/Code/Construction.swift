//
//  Construction.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func +(polynomial: Polynomial, variable: Variable) -> Polynomial {
    return polynomial.appending(variable: variable)
}

public func +(polynomial: Polynomial, constant: Int) -> Polynomial {
    return polynomial.appending(constant: constant)
}

public func +(polynomial: Polynomial, constant: Double) -> Polynomial {
    return polynomial.appending(constant: constant)
}

public func +(polynomial: Polynomial, term: Term) -> Polynomial {
    return polynomial.appending(term: term)
}

public func -(polynomial: Polynomial, term: Term) -> Polynomial {
    return polynomial + term.negated()
}

public func ^^(base: Variable, exponent: Double) -> Term {
    return Term(exponentiation: Exponentiation(base, exponent: exponent))
}

public func +(term: Term, constant: Double) -> Polynomial {
    return Polynomial(term).appending(constant: constant)
}
public func +(term: Term, constant: Int) -> Polynomial {
    return term + Double(constant)
}

public func +(term: Term, variable: Variable) -> Polynomial {
    return Polynomial(term).appending(variable: variable)
}

public func -(term: Term, variable: Variable) -> Polynomial {
    return Polynomial(term) - Polynomial(variable: variable)
}

public func +(term: Term, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(term).appending(exponentiation: exponentiation)
}

public func -(term: Term, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(term) - Polynomial(exponentiation: exponentiation)
}

public func +(exponentiation: Exponentiation, term: Term) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + Polynomial(term)
}

public func -(exponentiation: Exponentiation, term: Term) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) - Polynomial(term)
}

public func +(term: Term, other: Term) -> Polynomial {
    return Polynomial(term).appending(term: other)
}

public func -(term: Term, other: Term) -> Polynomial {
    return Polynomial(term) - Polynomial(other)
}

public func +(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
    return Polynomial(exponentiation: lhs) + Polynomial(exponentiation: rhs)
}

public func -(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
    return Polynomial(exponentiation: lhs) - Polynomial(exponentiation: rhs)
}

public func +(variable: Variable, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(variable: variable) + Polynomial(exponentiation: exponentiation)
}

public func -(variable: Variable, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(variable: variable) - Polynomial(exponentiation: exponentiation)
}

public func +(exponentiation: Exponentiation, variable: Variable) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + Polynomial(variable: variable)
}

public func -(exponentiation: Exponentiation, variable: Variable) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) - Polynomial(variable: variable)
}

public func +(exponentiation: Exponentiation, constant: Double) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + constant
}

public func +(exponentiation: Exponentiation, constant: Int) -> Polynomial {
    return exponentiation + Double(constant)
}

public func -(polynomial: Polynomial, constant: Double) -> Polynomial {
    return polynomial.subtracting(constant)
}

public func -(exponentiation: Exponentiation, constant: Double) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) - constant
}

public func -(exponentiation: Exponentiation, constant: Int) -> Polynomial {
    return exponentiation - Double(constant)
}

public func +(variable: Variable, constant: Double) -> Polynomial {
    return Polynomial(variable: variable) + constant
}

public func +(variable: Variable, constant: Int) -> Polynomial {
    return variable + Double(constant)
}

public func -(variable: Variable, constant: Double) -> Polynomial {
    return Polynomial(variable: variable) - constant
}

public func -(variable: Variable, constant: Int) -> Polynomial {
    return variable - Double(constant)
}

public func +(polynomial: Polynomial, other: Polynomial) -> Polynomial {
    return polynomial.appending(polynomial: other)
}

public func -(polynomial: Polynomial, other: Polynomial) -> Polynomial {
    return polynomial + other.negated()
}

public func +(polynomial: Polynomial, exponentiation: Exponentiation) -> Polynomial {
    return polynomial.appending(exponentiation: exponentiation)
}

public func -(polynomial: Polynomial, exponentiation: Exponentiation) -> Polynomial {
    return polynomial + Term(exponentiation: exponentiation, coefficient: -1)
}

public func *(coefficient: Int, term: Term) -> Term {
    return Double(coefficient) * term
}

public func *(coefficient: Double, term: Term) -> Term {
    return term.multiplyingCoefficient(by: coefficient)
}

public func *(coefficient: Double, variable: Variable) -> Term {
    return Term(exponentiation: Exponentiation(variable), coefficient: coefficient)
}

public func *(coefficient: Int, variable: Variable) -> Term {
    return Double(coefficient) * variable
}

public func *(coefficient: Double, exponentiation: Exponentiation) -> Term {
    return Term(exponentiation: exponentiation, coefficient: coefficient)
}

public func *(coefficient: Int, exponentiation: Exponentiation) -> Term {
    return Double(coefficient) * exponentiation
}

public func *(lhs: Exponentiation, rhs: Exponentiation) -> Term {
    return Term(exponentiation: lhs).appending(exponentiation: rhs)
}

public func ^^(base: Term, exponent: Double) -> Term {
    return base.multiplyingExponent(by: exponent)
}

public func ^^(base: Term, exponent: Int) -> Term {
    return base ^^ Double(exponent)
}

public func *(term: Term, variable: Variable) -> Term {
    return term.appending(variable: variable)
}

public func *(lhs: Variable, rhs: Variable) -> Term {
    return Term(lhs).appending(variable: rhs)
}

public func *(term: Term, exponentiation: Exponentiation) -> Term {
    return term.appending(exponentiation: exponentiation)
}
