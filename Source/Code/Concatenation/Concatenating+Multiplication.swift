//
//  Concatenating+Multiplication.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func *(lhs: Concatenating, rhs: Concatenating) -> Polynomial {
    return Polynomial(lhs).multiply(by: Polynomial(rhs))
}

// MARK: - Numberic Support
public func *(lhs: Concatenating, rhs: Int) -> Polynomial {
    return Polynomial(lhs).multiplied(by: rhs)
}
public func *(lhs: Int, rhs: Concatenating) -> Polynomial {
    return rhs * lhs
}
public func *(lhs: Concatenating, rhs: Double) -> Polynomial {
  return Polynomial(lhs).multiplied(by: rhs)
}
public func *(lhs: Double, rhs: Concatenating) -> Polynomial {
    return rhs * lhs
}


// MARK: - PRIVATE LOGIC
// MARK: - Numberic Support
private func *<F>(lhs: Concatenating, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
    return Polynomial(lhs).multiplied(by: rhs)
}

private func *<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
    return Polynomial(lhs).multiplied(by: rhs)
}

// MARK: - Multiplication is commutative
private func *<F>(lhs: F, rhs: Concatenating) -> Polynomial where F: BinaryFloatingPoint {
    return rhs * lhs
}

private func *<I>(lhs: I, rhs: Concatenating) -> Polynomial where I: BinaryInteger {
    return rhs * lhs
}

// MARK: - Private Extension Term
private extension Term {
    func appending(term other: Term) -> Term {
        // e.g. (2*x*y) * (3x^2*y^2)
        return Term(exponentiations: exponentiations + other.exponentiations, coefficient: coefficient*other.coefficient)
    }

    func multiplyingCoefficient(by number: Double) -> Term {
        return Term(exponentiations: exponentiations, coefficient: coefficient * number)
    }
}

// MARK: - Private Extension Polynomial
private extension Polynomial {
    func multiply(by other: Polynomial) -> Polynomial {
        var multipliedTerm = [Term]()
        for lhsTerm in terms {
            for rhsTerm in other.terms {
                multipliedTerm.append(lhsTerm.appending(term: rhsTerm))
            }
            if other.constant != 0 {
                multipliedTerm.append(lhsTerm.multiplyingCoefficient(by: other.constant))
            }
        }
        if constant != 0 {
            for rhsTerm in other.terms {
                multipliedTerm.append(rhsTerm.multiplyingCoefficient(by: constant))
            }
        }

        return Polynomial(terms: multipliedTerm, constant: constant * other.constant)
    }

    func multiplied<F>(by number: F) -> Polynomial where F: BinaryFloatingPoint {
        guard let firstTerm = terms.first else { return Polynomial(terms: [], constant: constant * Double(number)) }
        let termMultiplied = Term(exponentiations: firstTerm.exponentiations, coefficient: firstTerm.coefficient * Double(number))
        guard terms.count > 1 else { return Polynomial(termMultiplied, constant: constant) }
        let rest = terms.dropFirst()
        return Polynomial(terms: [termMultiplied] + rest, constant: constant)
    }

    func multiplied<I>(by number: I) -> Polynomial where I: BinaryInteger {
        return multiplied(by: Double(number))
    }
}
