//
//  TermProtocol+Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Differentiatable
public extension TermProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> PolynomialType? {
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
