//
//  Concatenating+Multiplication.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func *<N>(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(lhs).multiply(by: PolynomialStruct<N>(rhs))
}

//public func *(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<Int> {
//    return PolynomialStruct<Int>(lhs).multiply(by: PolynomialStruct<Int>(rhs))
//}
public func *(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).multiply(by: PolynomialStruct<Double>(rhs))
}

// MARK: - Numberic Support
public func *<N>(lhs: Concatenating, rhs: N) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(lhs).multiplied(by: rhs)
}
public func *<N>(lhs: N, rhs: Concatenating) -> PolynomialStruct<N> {
    return rhs * lhs
}

public func *(lhs: Concatenating, rhs: Double) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).multiplied(by: rhs)
}
public func *(lhs: Double, rhs: Concatenating) -> PolynomialStruct<Double> {
    return rhs * lhs
}

public func *(lhs: Concatenating, rhs: Int) -> PolynomialStruct<Double> {
    return lhs * Double(rhs)
}
public func *(lhs: Int, rhs: Concatenating) -> PolynomialStruct<Double> {
    return Double(lhs) * rhs
}

//public func *(lhs: Concatenating, rhs: Int) -> Polynomial {
//    return Polynomial(lhs).multiplied(by: rhs)
//}
//public func *(lhs: Int, rhs: Concatenating) -> Polynomial {
//    return rhs * lhs
//}
//public func *(lhs: Concatenating, rhs: Double) -> Polynomial {
//  return Polynomial(lhs).multiplied(by: rhs)
//}
//public func *(lhs: Double, rhs: Concatenating) -> Polynomial {
//    return rhs * lhs
//}


// MARK: - PRIVATE LOGIC
// MARK: - Numberic Support
//private func *<F>(lhs: Concatenating, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
//    return Polynomial(lhs).multiplied(by: rhs)
//}
//
//private func *<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
//    return Polynomial(lhs).multiplied(by: rhs)
//}
//
//// MARK: - Multiplication is commutative
//private func *<F>(lhs: F, rhs: Concatenating) -> Polynomial where F: BinaryFloatingPoint {
//    return rhs * lhs
//}
//
//private func *<I>(lhs: I, rhs: Concatenating) -> Polynomial where I: BinaryInteger {
//    return rhs * lhs
//}

// MARK: - Private Extension Term
private extension TermProtocol {
    func appending(term other: Self) -> Self {
        // e.g. (2*x*y) * (3x^2*y^2)
        return Self(exponentiations: exponentiations + other.exponentiations, coefficient: coefficient*other.coefficient)
    }

    func multiplyingCoefficient(by number: NumberType) -> Self {
        return Self(exponentiations: exponentiations, coefficient: coefficient * number)
    }
}

// MARK: - Private Extension Polynomial
private extension PolynomialProtocol {
    func multiply(by other: Self) -> Self {
        var multipliedTerm = [TermType]()
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

        return Self(terms: multipliedTerm, constant: constant * other.constant)
    }

    func multiplied(by number: NumberType) -> Self {
        guard let firstTerm = terms.first else { return Self(terms: [], constant: constant * number) }
        let termMultiplied = TermType(exponentiations: firstTerm.exponentiations, coefficient: firstTerm.coefficient * number)
        guard terms.count > 1 else { return Self(termMultiplied, constant: constant) }
        let rest = terms.dropFirst()
        return Self(terms: [termMultiplied] + rest, constant: constant)
    }

//    func multiplied<F>(by number: F) -> Self where F: BinaryFloatingPoint {
//
//    }

//    func multiplied<I>(by number: I) -> Self where I: BinaryInteger {
//        return multiplied(by: Double(number))
//    }
}

public func ^^<N>(lhs: Concatenating, rhs: N) -> PolynomialStruct<N> where N: IntegerNumberExpressible {
    return PolynomialStruct<N>(lhs).raised(to: Int(rhs))
}
public func ^^(lhs: Concatenating, rhs: Int) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).raised(to: rhs)
}

//// MARK: - Internal
//internal func ^^<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
//    return Polynomial(lhs).raised(to: rhs)
//}


// MARK: - Polynomial
private extension PolynomialProtocol {
    func raised(to exponent: Int) -> Self  {

        var polynomialExponentiated = Self(constant: 1)

        // base * base * base ... // exponent times
        for _ in 0..<exponent {
            polynomialExponentiated = polynomialExponentiated.multiply(by: self)
        }
        return polynomialExponentiated
    }
}
