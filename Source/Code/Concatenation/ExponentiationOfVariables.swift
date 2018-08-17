//
//  ExponentiationOfVariables.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation




public func ^^(base: Variable, exponent: Double) -> Term {
    return Term(exponentiation: Exponentiation(base, exponent: exponent))
}

public func ^^(base: Term, exponent: Double) -> Term {
    return base.multiplyingExponent(by: exponent)
}

public func ^^(base: Term, exponent: Int) -> Term {
    return base ^^ Double(exponent)
}

