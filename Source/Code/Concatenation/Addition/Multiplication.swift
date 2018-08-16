//
//  Multiplication.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
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
public func *(term: Term, variable: Variable) -> Term {
    return term.appending(variable: variable)
}

public func *(lhs: Variable, rhs: Variable) -> Term {
    return Term(lhs).appending(variable: rhs)
}

public func *(term: Term, exponentiation: Exponentiation) -> Term {
    return term.appending(exponentiation: exponentiation)
}
