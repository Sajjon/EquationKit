
//
//  Concatenating.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Concatenating {
    func asVariable() -> Variable?
    func asExponentiation() -> Exponentiation?
    func asTerm() -> Term?
    func asPolynomial() -> Polynomial?
}

public extension Concatenating {
    func asVariable() -> Variable? { return nil }
    func asExponentiation() -> Exponentiation? { return nil }
    func asTerm() -> Term? { return nil }
    func asPolynomial() -> Polynomial? { return nil }
}

// MARK: - Polynomial init Concatenating
public extension Polynomial {

    init(_ concatenating: Concatenating) {
        if let variable = concatenating.asVariable() {
            self.init(variable: variable)
        } else if let exponentiation = concatenating.asExponentiation() {
            self.init(exponentiation: exponentiation)
        } else if let term = concatenating.asTerm() {
            self.init(term: term)
        } else if let polynomial = concatenating.asPolynomial() {
            self.init(terms: polynomial.terms, constant: polynomial.constant)
        } else {
            fatalError("unhandled")
        }
    }
}

// Not sure about this... It seems to reduce compilation time? But should not be necessary?
public func +(lhs: Concatenating, rhs: Concatenating) -> Polynomial {
    return Polynomial(lhs).appending(polynomial: Polynomial(rhs))
}
