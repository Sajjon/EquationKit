//
//  Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NumberTypeSpecifying {
    associatedtype NumberType: NumberExpressible
}

public protocol VariableTypeSpecifying {
    associatedtype VariableType: VariableProtocol
}
public protocol Differentiatable: VariableTypeSpecifying {
    //where PolynomialType.TermType.ExponentiationType.VariableType == Self.VariableType {
    associatedtype PolynomialType: PolynomialProtocol
    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> PolynomialType?

}

// MARK: - Differentiatable
public extension PolynomialProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> Self? {
        guard contains(variable: variableToDifferentiate) else { return Self(constant: NumberType.zero) }
        var terms = [TermType]()
        var constant: NumberType = .zero
        for term in self.terms {
            guard let differentiationResult = term.differentiateWithRespectTo(variableToDifferentiate) else { continue }
            if differentiationResult.terms.isEmpty && !differentiationResult.constant.isZero {
                constant += differentiationResult.constant
            } else if differentiationResult.terms.count == 1 && differentiationResult.constant.isZero, let term = differentiationResult.terms.first {
                terms.append(term)
            } else {
                fatalError("should not happen")
            }

        }
        return Self(terms: terms, constant: constant)
    }
}



// MARK: - Differentiatable
public extension TermProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> PolynomialType? {
        guard contains(variable: variableToDifferentiate) else { return nil }

        var exponentiations = [ExponentiationType]()
        var coefficient = self.coefficient
        for exponentiation in self.exponentiations {
            guard let differentiationResult = exponentiation.differentiateWithRespectTo(variableToDifferentiate) else { exponentiations.append(exponentiation); continue }

            guard let term = differentiationResult.terms.first else { continue }
            guard differentiationResult.terms.count == 1 else { fatalError("what? bad state...") }

            coefficient *= term.coefficient
            guard let exponentiation = term.exponentiations.first, term.exponentiations.count == 1 else { return nil }
            exponentiations.append(exponentiation)
        }

        if exponentiations.count == 0 {
            return PolynomialType(constant: coefficient)
        } else {
            let term = Self(exponentiations: exponentiations, coefficient: coefficient)
            return PolynomialType(term: term)
        }
    }
}

// MARK: - Differentiatable
public extension ExponentiationProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> PolynomialType? {
        guard variableToDifferentiate == variable else { return PolynomialType(exponentiation: self) }
        let exponentPriorToDifferentiation = self.exponent
        let exponent = exponentPriorToDifferentiation - 1
        guard exponent > 0 else {
            // actually this is never used.... but makes us able to distinguish between
            // doing `exponentiations.append(exponentiation)` and doing
            // nothing in differentiation in TermProtocol
            return PolynomialType(constant: NumberType.one)
        }

        let exponentiation = Self(variable, exponent: exponent)
        let term = PolynomialType.TermType(exponentiation: exponentiation, coefficient: exponentPriorToDifferentiation)
        return PolynomialType(term: term)
    }

}
