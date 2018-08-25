//
//  PolynomialProtocol+Quasi-Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Differentiatable LIKE but cannot mark conformance because it would result in circular reference
public extension PolynomialProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> Polynomial<NumberType>? {
        guard contains(variable: variableToDifferentiate) else { return Polynomial(constant: NumberType.zero) }
        var terms = [Polynomial<NumberType>.TermType]()
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
        return Polynomial(terms: terms, constant: constant)
    }
}
