//
//  Subtraction.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation


public func -(term: Term, variable: Variable) -> Polynomial {
    return Polynomial(term) - Polynomial(variable: variable)
}


public func -(term: Term, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(term) - Polynomial(exponentiation: exponentiation)
}


public func -(exponentiation: Exponentiation, term: Term) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) - Polynomial(term)
}


public func -(term: Term, other: Term) -> Polynomial {
    return Polynomial(term) - Polynomial(other)
}

public func -(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
    return Polynomial(exponentiation: lhs) - Polynomial(exponentiation: rhs)
}


public func -(variable: Variable, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(variable: variable) - Polynomial(exponentiation: exponentiation)
}


public func -(exponentiation: Exponentiation, variable: Variable) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) - Polynomial(variable: variable)
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



public func -(variable: Variable, constant: Double) -> Polynomial {
    return Polynomial(variable: variable) - constant
}

public func -(variable: Variable, constant: Int) -> Polynomial {
    return variable - Double(constant)
}


public func -(polynomial: Polynomial, other: Polynomial) -> Polynomial {
    return polynomial + other.negated()
}
public func -(polynomial: Polynomial, exponentiation: Exponentiation) -> Polynomial {
    return polynomial + Term(exponentiation: exponentiation, coefficient: -1)
}
public func -(polynomial: Polynomial, term: Term) -> Polynomial {
    return polynomial + term.negated()
}
