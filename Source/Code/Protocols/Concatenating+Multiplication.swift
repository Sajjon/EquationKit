//
//  Concatenating+Multiplication.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: -
// MARK: - Number -
// MARK: -

// MARK: - Variable
//public func *<F>(lhs: Variable, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
//    return (lhs as Concatenating) * rhs
//}
//public func *(lhs: Variable, rhs: Double) -> Polynomial {
//    return (lhs as Concatenating) * rhs
//}

//public func *<I>(lhs: Variable, rhs: I) -> Polynomial where I: BinaryInteger {
//    return (lhs as Concatenating) * rhs
//}
public func *(lhs: Variable, rhs: Int) -> Polynomial {
    return (lhs as Concatenating) * rhs
}

//public func *<F>(lhs: F, rhs: Variable) -> Polynomial where F: BinaryFloatingPoint {
//    return lhs * (rhs as Concatenating)
//}
//public func *(lhs: Double, rhs: Variable) -> Polynomial {
//    return lhs * (rhs as Concatenating)
//}
//public func *<I>(lhs: I, rhs: Variable) -> Polynomial where I: BinaryInteger {
//    return lhs * (rhs as Concatenating)
//}
public func *(lhs: Int, rhs: Variable) -> Polynomial {
    return lhs * (rhs as Concatenating)
}

// MARK: - Exponentiation
//public func *<F>(lhs: Exponentiation, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
//    return (lhs as Concatenating) * rhs
//}
//public func *(lhs: Exponentiation, rhs: Double) -> Polynomial {
//    return (lhs as Concatenating) * rhs
//}
//
//public func *<I>(lhs: Exponentiation, rhs: I) -> Polynomial where I: BinaryInteger {
//    return (lhs as Concatenating) * rhs
//}
public func *(lhs: Exponentiation, rhs: Int) -> Polynomial {
    return (lhs as Concatenating) * rhs
}

//public func *<F>(lhs: F, rhs: Exponentiation) -> Polynomial where F: BinaryFloatingPoint {
//    return lhs * (rhs as Concatenating)
//}
//public func *(lhs: Double, rhs: Exponentiation) -> Polynomial {
//    return lhs * (rhs as Concatenating)
//}
//
//public func *<I>(lhs: I, rhs: Exponentiation) -> Polynomial where I: BinaryInteger {
//    return lhs * (rhs as Concatenating)
//}
public func *(lhs: Int, rhs: Exponentiation) -> Polynomial {
    return lhs * (rhs as Concatenating)
}

// MARK: - Term
//public func *<F>(lhs: Term, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
//    return (lhs as Concatenating) * rhs
//}
//
//public func *<I>(lhs: Term, rhs: I) -> Polynomial where I: BinaryInteger {
//    return (lhs as Concatenating) * rhs
//}
//
//public func *<F>(lhs: F, rhs: Term) -> Polynomial where F: BinaryFloatingPoint {
//    return lhs * (rhs as Concatenating)
//}
//
//public func *<I>(lhs: I, rhs: Term) -> Polynomial where I: BinaryInteger {
//    return lhs * (rhs as Concatenating)
//}

// MARK: - Polynomial
//public func *<F>(lhs: Polynomial, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
//    return (lhs as Concatenating) * rhs
//}
//
//public func *<I>(lhs: Polynomial, rhs: I) -> Polynomial where I: BinaryInteger {
//    return (lhs as Concatenating) * rhs
//}
//
//public func *<F>(lhs: F, rhs: Polynomial) -> Polynomial where F: BinaryFloatingPoint {
//    return lhs * (rhs as Concatenating)
//}
//
//public func *<I>(lhs: I, rhs: Polynomial) -> Polynomial where I: BinaryInteger {
//    return lhs * (rhs as Concatenating)
//}
public func *(lhs: Int, rhs: Polynomial) -> Polynomial {
    return lhs * (rhs as Concatenating)
}


// MARK: -
// MARK: - Variable -
// MARK: -

// MARK: - Variable
public func *(lhs: Variable, rhs: Variable) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: - Exponentiation
public func *(lhs: Variable, rhs: Exponentiation) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

public func *(lhs: Exponentiation, rhs: Variable) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: - Term
public func *(lhs: Variable, rhs: Term) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

public func *(lhs: Term, rhs: Variable) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: - Polynomial
public func *(lhs: Variable, rhs: Polynomial) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

public func *(lhs: Polynomial, rhs: Variable) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: -
// MARK: - Exponentiation -
// MARK: -
// MARK: - Exponentiation
public func *(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: - Term
public func *(lhs: Term, rhs: Exponentiation) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

public func *(lhs: Exponentiation, rhs: Term) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: - Polynomial
public func *(lhs: Polynomial, rhs: Exponentiation) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

public func *(lhs: Exponentiation, rhs: Polynomial) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: -
// MARK: - Term -
// MARK: -
public func *(lhs: Term, rhs: Term) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: - Polynomial
public func *(lhs: Polynomial, rhs: Term) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

public func *(lhs: Term, rhs: Polynomial) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}

// MARK: -
// MARK: - Polynomial -
// MARK: -
// MARK: - Polynomial
public func *(lhs: Polynomial, rhs: Polynomial) -> Polynomial {
    return (lhs as Concatenating) * (rhs as Concatenating)
}
















// MARK: - PRIVATE LOGIC
private func *(lhs: Concatenating, rhs: Concatenating) -> Polynomial {
    return Polynomial(lhs).multiply(by: Polynomial(rhs))
}

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

private func *(lhs: Term, rhs: Term) -> Term {
    return lhs.appending(term: rhs)
}

private func *(coefficient: Double, term: Term) -> Term {
    return term.multiplyingCoefficient(by: coefficient)
}

// MARK: - Private Extension Polynomial
private extension Polynomial {
    func multiply(by other: Polynomial) -> Polynomial {

        let lhs = self
        let rhs = other

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
