
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

// MARK: - Conformance - Variable
extension Variable: Concatenating {}
public extension Variable {
    func asVariable() -> Variable? { return self }
}

// MARK: - Conformance - Exponentiation
extension Exponentiation: Concatenating {}
public extension Exponentiation {
    func asExponentiation() -> Exponentiation? { return self }
}

// MARK: - Conformance - Term
extension Term: Concatenating {}
public extension Term {
    func asTerm() -> Term? { return self }
}

// MARK: - Conformance - Variable
extension Polynomial: Concatenating {}
public extension Polynomial {
    func asPolynomial() -> Polynomial? { return self }
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
