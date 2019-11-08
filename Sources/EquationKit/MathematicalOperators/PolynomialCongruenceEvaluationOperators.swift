//
//  PolynomialCongruenceEvaluationOperators.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Non special unicode char operators
infix operator =%=: AssignmentPrecedence
public func =%= <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial.evaluate(constants: congruence.constants, modulus: congruence.modulus) == congruence.scalar
}

infix operator =!%=: AssignmentPrecedence
public func =!%= <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return !(polynomial ≡≡ congruence)
}

// MARK: Special unicode char corresponding operators
infix operator ≡≡: AssignmentPrecedence
public func ≡≡ <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial =%= congruence
}

infix operator !≡: AssignmentPrecedence
public func !≡ <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial =!%= congruence
}

infix operator ≢: AssignmentPrecedence
public func ≢ <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial !≡ congruence
}
