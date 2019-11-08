//
//  PolynomialProtocol+Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Differentiatable
public extension PolynomialProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> PolynomialType<NumberType>? {
        guard contains(variable: variableToDifferentiate) else { return PolynomialType(constant: NumberType.zero) }
        var terms = [PolynomialType<NumberType>.TermType]()
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
        return PolynomialType(terms: terms, constant: constant)
    }
}

// MARK: - Public Extensions
public extension PolynomialProtocol {
    func contains(variable: VariableStruct<NumberType>) -> Bool {
        for term in terms {
            guard term.contains(variable: variable) else { continue }
            return true
        }
        return false
    }
}
