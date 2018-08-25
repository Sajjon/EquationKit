//
//  OperatorSupport.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public extension PolynomialProtocol {
    init<NS>(atom: NS) where NS: NumberTypeSpecifying, NS.NumberType == Self.NumberType  {
        if let variable = atom as? VariableStruct<NumberType> {
            self.init(variable: variable)
        }
        else if let exponentiation = atom as? ExponentiationType {
            self.init(exponentiation: exponentiation, constant: NumberType.zero)
        }
        else if let term = atom as? TermType {
            self.init(term: term)
        }
        else if let polynomial = atom as? Self {
            self.init(terms: polynomial.terms, constant: polynomial.constant)
        }
        else {
            fatalError("unhandled, self.numbertype")
        }

    }
}

// MARK: - Addition
//public func +<N, NS>(lhs: NS, rhs: NS) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
//    return Polynomial<N>(atom: lhs).appending(polynomial: Polynomial<N>(atom: rhs))
//}
//public func +<N, LHS, RHS>(lhs: LHS, rhs: RHS) -> Polynomial<N> where LHS: NumberTypeSpecifying, RHS: NumberTypeSpecifying, LHS.NumberType == N, RHS.NumberType == N {
//    return Polynomial<N>(atom: lhs).appending(polynomial: Polynomial<N>(atom: rhs))
//}

public func +<N, NS>(lhs: NS, rhs: N) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return Polynomial<N>(atom: lhs).adding(constant: rhs)
}

// Addition is commutative
public func +<N, NS>(lhs: N, rhs: NS) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return rhs + lhs
}

// MARK: - Multiplication
//public func *<N, NS>(lhs: NS, rhs: NS) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
//    return Polynomial<N>(atom: lhs).multiply(by: Polynomial<N>(atom: rhs))
//}
//public func *<N, LHS, RHS>(lhs: LHS, rhs: RHS) -> Polynomial<N> where LHS: NumberTypeSpecifying, RHS: NumberTypeSpecifying, LHS.NumberType == N, RHS.NumberType == N {
//    return Polynomial<N>(atom: lhs).multiply(by: Polynomial<N>(atom: rhs))
//}

public func *<N, NS>(lhs: NS, rhs: N) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return Polynomial<N>(atom: lhs).multipliedBy(constant: rhs)
}

// Multiplication is commutative
public func *<N, NS>(lhs: N, rhs: NS) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return rhs * lhs
}

// MARK: - Subtraction
public func -<N, NS>(lhs: NS, rhs: NS) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return Polynomial<N>(atom: lhs).subtracting(other: Polynomial<N>(atom: rhs))
}
public func -<N, LHS, RHS>(lhs: LHS, rhs: RHS) -> Polynomial<N> where LHS: NumberTypeSpecifying, RHS: NumberTypeSpecifying, LHS.NumberType == N, RHS.NumberType == N {
    return Polynomial<N>(atom: lhs).subtracting(other: Polynomial<N>(atom: rhs))
}

public func -<N, NS>(lhs: NS, rhs: N) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return Polynomial<N>(atom: lhs).subtracting(constant: rhs)
}

public func -<N, NS>(lhs: N, rhs: NS) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return Polynomial<N>(atom: rhs).negated().adding(constant: lhs)
}

// MARK: - Exponentiation
public func ^^<N, NS>(lhs: NS, rhs: Int) -> Polynomial<N> where NS: NumberTypeSpecifying, NS.NumberType == N {
    return Polynomial<N>(atom: lhs).raised(to: rhs)
}


//typealias Variabel = VariableStruct<Double>
//typealias Exp = ExponentiationStruct<Double>
//typealias Term = TermStruct<Exp>
//typealias Eq = Polynomial<Double>
//
//let x = Variabel("x")
//let y = Variabel("y")
//let x² = Exp(x, exponent: 2)
//let x³ = Exp(x, exponent: 3)
//let y² = Exp(x, exponent: 2)
//let y³ = Exp(x, exponent: 3)
//let txy: Term = { return (x*y).terms[0] }()
//let tx²y: Term = { return (x²*y).terms[0] }()
//let eq: Eq = x * y²





/*
func addition() {
    x + 1
    x + 1.5
    1 + x
    1.5 + x

    x + y

    x² + 1
    x² + 1.5
    1 + x²
    1.5 + x²

    x² + y²
    x² + x
    x + x²

    1 + txy
    1.5 + txy
    txy + 1
    txy + 1.5

    txy + x
    x + txy



    eq + 1
    eq + 1.5
    1 + eq
    1.5 + eq

    x + eq
    eq + x

    eq + y³
    y³ + eq

    eq + txy
    eq + tx²y
    tx²y + eq

}

func subtraction() {
    x - 1
    x - 1.5
    1 - x
    1.5 - x

    x - y

    x² - 1
    x² - 1.5
    1 - x²
    1.5 - x²

    x² - y²
    x² - x
    x - x²

    1 - txy
    1.5 - txy
    txy - 1
    txy - 1.5

    txy - x
    x - txy



    eq - 1
    eq - 1.5
    1 - eq
    1.5 - eq

    x - eq
    eq - x

    eq - y³
    y³ - eq

    eq - txy
    eq - tx²y
    tx²y - eq

}

func multiply() {
    x * 1
    x * 1.5
    1 * x
    1.5 * x

    x * y

    x² * 1
    x² * 1.5
    1 * x²
    1.5 * x²

    x² * y²
    x² * x
    x * x²

    1 * txy
    1.5 * txy
    txy * 1
    txy * 1.5

    txy * x
    x * txy



    eq * 1
    eq * 1.5
    1 * eq
    1.5 * eq

    x * eq
    eq * x

    eq * y³
    y³ * eq

    eq * txy
    eq * tx²y
    tx²y * eq
}

func raisedTo() {
    x^^11
    x²^^11
    txy^^11
    eq^^11
}

 */
