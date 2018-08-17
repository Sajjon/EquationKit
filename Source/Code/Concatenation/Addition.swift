//
//  Add.swift
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
/// Addition is commutative, use `Variable + Number`
public func +(constant: Double, variable: Variable) -> Polynomial {
    return variable + constant
}

public func +(constant: Int, variable: Variable) -> Polynomial {
    return Double(constant) + variable
}

// MARK: - Exponentiation RHS
/// Addition is commutative, use `Exponentiation + Number`
public func +(constant: Double, exponentiation: Exponentiation) -> Polynomial {
    return exponentiation + constant
}

public func +(constant: Int, exponentiation: Exponentiation) -> Polynomial {
    return  Double(constant) + exponentiation
}

// MARK: - Term RHS
/// Addition is commutative, use `Term + Number`
public func +(constant: Double, term: Term) -> Polynomial {
    return term + constant
}

public func +(constant: Int, term: Term) -> Polynomial {
    return Double(constant) + term
}

// MARK: - Polynomial RHS
/// Addition is commutative, use `Polynomial + Number`
public func +(constant: Double, polynomial: Polynomial) -> Polynomial {
    return polynomial + constant
}

public func +(constant: Int, polynomial: Polynomial) -> Polynomial {
    return Double(constant) + polynomial
}

// MARK: -
// MARK: - Variable LHS -
// MARK: -

// MARK: - Numbers RHS
public func +(variable: Variable, constant: Double) -> Polynomial {
    return Polynomial(variable: variable) + constant
}

public func +(variable: Variable, constant: Int) -> Polynomial {
    return variable + Double(constant)
}

// MARK: - Variable RHS
public func +(lhs: Variable, rhs: Variable) -> Polynomial {
    return Polynomial(variable: lhs) + Polynomial(variable: rhs)
}

// MARK: - Exponentiation RHS
public func +(variable: Variable, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(variable: variable) + Polynomial(exponentiation: exponentiation)
}

// MARK: - Term RHS
public func +(variable: Variable, term: Term) -> Polynomial {
    return Polynomial(variable: variable) + Polynomial(term)
}

// MARK: - Polynomial RHS
public func +(variable: Variable, polynomial: Polynomial) -> Polynomial {
    return Polynomial(variable: variable) + polynomial
}

// MARK: -
// MARK: - Exponentiation LHS -
// MARK: -

// MARK: - Numbers RHS
public func +(exponentiation: Exponentiation, constant: Double) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + constant
}

public func +(exponentiation: Exponentiation, constant: Int) -> Polynomial {
    return exponentiation + Double(constant)
}

// MARK: - Variable RHS
public func +(exponentiation: Exponentiation, variable: Variable) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + Polynomial(variable: variable)
}

// MARK: - Exponentiation RHS
public func +(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
    return Polynomial(exponentiation: lhs) + Polynomial(exponentiation: rhs)
}

// MARK: - Term RHS
public func +(exponentiation: Exponentiation, term: Term) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + Polynomial(term)
}

// MARK: - Polynomial RHS
public func +(exponentiation: Exponentiation, polynomial: Polynomial) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + polynomial
}






// MARK: -
// MARK: - Term LHS -
// MARK: -

// MARK: - Numbers RHS
public func +(term: Term, constant: Double) -> Polynomial {
    return Polynomial(term).appending(constant: constant)
}

public func +(term: Term, constant: Int) -> Polynomial {
    return term + Double(constant)
}

// MARK: - Variable RHS
public func +(term: Term, variable: Variable) -> Polynomial {
    return Polynomial(term).appending(variable: variable)
}

// MARK: - Exponentiation RHS
public func +(term: Term, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(term).appending(exponentiation: exponentiation)
}

// MARK: - Term RHS
public func +(term: Term, other: Term) -> Polynomial {
    return Polynomial(term).appending(term: other)
}

// MARK: - Polynomial RHS
public func +(term: Term, polynomial: Polynomial) -> Polynomial {
    return Polynomial(term) + polynomial
}

// MARK: -
// MARK: - Polynomial LHS -
// MARK: -

// MARK: - Numbers RHS
public func +(polynomial: Polynomial, constant: Int) -> Polynomial {
    return polynomial.appending(constant: constant)
}

public func +(polynomial: Polynomial, constant: Double) -> Polynomial {
    return polynomial.appending(constant: constant)
}

// MARK: - Variable RHS
public func +(polynomial: Polynomial, variable: Variable) -> Polynomial {
    return polynomial.appending(variable: variable)
}

// MARK: - Exponentiation RHS
public func +(polynomial: Polynomial, exponentiation: Exponentiation) -> Polynomial {
    return polynomial.appending(exponentiation: exponentiation)
}

// MARK: - Term RHS
public func +(polynomial: Polynomial, term: Term) -> Polynomial {
    return polynomial.appending(term: term)
}

// MARK: - Polynomial RHS
public func +(polynomial: Polynomial, other: Polynomial) -> Polynomial {
    return polynomial.appending(polynomial: other)
}

