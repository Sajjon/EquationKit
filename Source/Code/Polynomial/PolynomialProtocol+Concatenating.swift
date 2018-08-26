//
//  PolynomialProtocol+Concatenating.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Appending
public extension PolynomialProtocol {

    func adding(other: Self) -> Self {
        return Self(terms: terms + other.terms, constant: constant + other.constant)
    }

    func adding(constant: NumberType) -> Self {
        return Self.init(terms: terms, constant: self.constant + constant)
    }

}

// MARK: - Subtracting
public extension PolynomialProtocol {

    func subtracting(other: Self) -> Self {
        return self.adding(other: other.negated())
    }

    func subtracting(constant: NumberType) -> Self {
        return Self(terms: terms, constant: self.constant - constant)
    }


}

// MARK: - Multiplying
public extension PolynomialProtocol {
    func multipliedBy(other: Self) -> Self {
        var multipliedTerm = [TermType]()
        for lhsTerm in terms {
            for rhsTerm in other.terms {
                multipliedTerm.append(lhsTerm.multipliedBy(other: rhsTerm))
            }
            if other.constant != 0 {
                multipliedTerm.append(lhsTerm.multiplyingCoefficientBy(constant: other.constant))
            }
        }
        if constant != 0 {
            for rhsTerm in other.terms {
                multipliedTerm.append(rhsTerm.multiplyingCoefficientBy(constant: constant))
            }
        }

        return Self(terms: multipliedTerm, constant: constant * other.constant)
    }

    func multipliedBy(constant: NumberType) -> Self {
        guard let firstTerm = terms.first else { return Self(terms: [], constant: constant * constant) }
        let termMultiplied = TermType(exponentiations: firstTerm.exponentiations, coefficient: firstTerm.coefficient * constant)
        guard terms.count > 1 else { return Self(termMultiplied) }
        let rest = terms.dropFirst()
        return Self(terms: [termMultiplied] + rest, constant: constant)
    }


}

// MARK: - Exponentiating
public extension PolynomialProtocol {
    func raised(to exponent: Int) -> Self  {

        var polynomialExponentiated = Self(constant: 1)

        for _ in 0..<exponent {
            polynomialExponentiated = polynomialExponentiated.multipliedBy(other: self)
        }
        return polynomialExponentiated
    }


}
