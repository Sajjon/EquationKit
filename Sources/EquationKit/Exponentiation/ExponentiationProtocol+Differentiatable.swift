//
//  ExponentiationProtocol+Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Differentiatable
public extension ExponentiationProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> PolynomialType<NumberType>? {

        guard let _ = variable.differentiateWithRespectTo(variableToDifferentiate) else {
            return PolynomialType(exponentiation: self as! PolynomialType<NumberType>.ExponentiationType)
        }

        let exponentPriorToDifferentiation = self.exponent
        let exponent = exponentPriorToDifferentiation - 1
        guard exponent > 0 else {
            // actually this is never used.... but makes us able to distinguish between
            // doing `exponentiations.append(exponentiation)` and doing
            // nothing in differentiation in TermProtocol
            return PolynomialType(constant: NumberType.one)
        }

        let exponentiation = PolynomialType.ExponentiationType(variable, exponent: exponent)
        let term = PolynomialType.TermType(exponentiation: exponentiation, coefficient: exponentPriorToDifferentiation)!
        return PolynomialType(term: term)
    }

}
