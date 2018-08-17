//
//  Multiplication.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: -
// MARK: - Number LHS -
// MARK: -

// MARK: - Numbers RHS (Not implemented), lets use Swift Foundation, shall we?
// MARK: - Variable RHS
public func *(coefficient: Double, variable: Variable) -> Term {
    return Term(exponentiation: Exponentiation(variable), coefficient: coefficient)
}

public func *(coefficient: Int, variable: Variable) -> Term {
    return Double(coefficient) * variable
}

// MARK: - Exponentiation RHS
public func *(coefficient: Double, exponentiation: Exponentiation) -> Term {
    return Term(exponentiation: exponentiation, coefficient: coefficient)
}

public func *(coefficient: Int, exponentiation: Exponentiation) -> Term {
    return Double(coefficient) * exponentiation
}

// MARK: - Term RHS
public func *(coefficient: Double, term: Term) -> Term {
    return term.multiplyingCoefficient(by: coefficient)
}

public func *(coefficient: Int, term: Term) -> Term {
    return Double(coefficient) * term
}

// MARK: - Polynomial RHS
public func *(coefficient: Double, polynomial: Polynomial) -> Polynomial {
    return polynomial.multiplied(by: coefficient)
}

public func *(coefficient: Int, polynomial: Polynomial) -> Polynomial {
    return Double(coefficient) * polynomial
}


// MARK: -
// MARK: - Variable LHS -
// MARK: -

// MARK: - Numbers RHS
/// Multiplication is commutative, use `Number * Variable`
public func *(variable: Variable, coefficient: Double) -> Term {
    return coefficient * variable
}

public func *(variable: Variable, coefficient: Int) -> Term {
    return variable * Double(coefficient)
}

// MARK: - Variable RHS
public func *(lhs: Variable, rhs: Variable) -> Term {
    return Term(lhs) * rhs
}

// MARK: - Exponentiation RHS
public func *(variable: Variable, exponentiation: Exponentiation) -> Term {
    return Term(variable) * exponentiation
}

// MARK: - Term RHS
public func *(variable: Variable, term: Term) -> Term {
    return term.appending(variable: variable)
}

// MARK: - Polynomial RHS
public func *(variable: Variable, polynomial: Polynomial) -> Polynomial {
    return Polynomial(variable: (variable)) * polynomial
}

// MARK: -
// MARK: - Exponentiation LHS -
// MARK: -

// MARK: - Numbers RHS
/// Multiplication is commutative, use `Number * Exponentiation`
public func *(exponentiation: Exponentiation, constant: Double) -> Term {
    return constant * exponentiation
}

public func *(exponentiation: Exponentiation, constant: Int) -> Term {
    return exponentiation * Double(constant)
}

// MARK: - Variable RHS
/// Multiplication is commutative, use `Variable * Exponentiation`
public func *(exponentiation: Exponentiation, variable: Variable) -> Term {
    return variable * exponentiation
}

// MARK: - Exponentiation RHS
public func *(lhs: Exponentiation, rhs: Exponentiation) -> Term {
    return Term(exponentiation: lhs).appending(exponentiation: rhs)
}

// MARK: - Term RHS
/// Multiplication is commutative, use `Term * Exponentiation`
public func *(exponentiation: Exponentiation, term: Term) -> Term {
    return term * exponentiation
}

// MARK: - Polynomial RHS
/// Multiplication is commutative, use `Polynomial * Exponentiation`
public func *(exponentiation: Exponentiation, polynomial: Polynomial) -> Polynomial {
    return polynomial * exponentiation
}


// MARK: -
// MARK: - Term LHS -
// MARK: -

// MARK: - Numbers RHS
/// Multiplication is commutative, use `Number * Term`
public func *(term: Term, constant: Double) -> Term {
    return constant * term
}

public func *(term: Term, constant: Int) -> Term {
    return term * Double(constant)
}

// MARK: - Variable RHS
public func *(term: Term, variable: Variable) -> Term {
    return term.appending(variable: variable)
}

// MARK: - Exponentiation RHS
public func *(term: Term, exponentiation: Exponentiation) -> Term {
    return term.appending(exponentiation: exponentiation)
}

// MARK: - Term RHS
public func *(lhs: Term, rhs: Term) -> Term {
    return lhs.appending(term: rhs)
}

// MARK: - Polynomial RHS
public func *(term: Term, polynomial: Polynomial) -> Polynomial {
    return Polynomial(term) * polynomial
}


// MARK: -
// MARK: - Polynomial LHS -
// MARK: -

// MARK: - Numbers RHS
/// Multiplication is commutative, use `Number * Polynomial`
public func *(polynomial: Polynomial, constant: Double) -> Polynomial {
    return constant * polynomial
}

public func *(polynomial: Polynomial, constant: Int) -> Polynomial {
    return polynomial * Double(constant)
}

// MARK: - Variable RHS
/// Multiplication is commutative, use `Number * Polynomial`
public func *(polynomial: Polynomial, variable: Variable) -> Polynomial {
    return variable * polynomial
}

// MARK: - Exponentiation RHS
public func *(polynomial: Polynomial, exponentiation: Exponentiation) -> Polynomial {
    return polynomial * Term(exponentiation: exponentiation)
}

// MARK: - Term RHS
/// Multiplication is commutative, use `Number * Term`
public func *(polynomial: Polynomial, term: Term) -> Polynomial {
    return term * polynomial
}

// MARK: - Polynomial RHS
public func *(lhs: Polynomial, rhs: Polynomial) -> Polynomial {

    // ..... L H S .... * .... R H S ...
    // (x*y + 2*x + 13) * (3*y - 7*x - 9)
    var multipliedTerm = [Term]()
    for lhsTerm in lhs.terms {
        for rhsTerm in rhs.terms {
            multipliedTerm.append(lhsTerm * rhsTerm)
        }
        if rhs.constant != 0 {
            multipliedTerm.append(rhs.constant * lhsTerm)
        }
    }
    if lhs.constant != 0 {
        for rhsTerm in rhs.terms {
            multipliedTerm.append(lhs.constant * rhsTerm)
        }
    }

    let constant = lhs.constant * rhs.constant

    return Polynomial(terms: multipliedTerm, constant: constant)
}




