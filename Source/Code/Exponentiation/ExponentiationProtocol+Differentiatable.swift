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

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> Polynomial<NumberType>? {
        guard variableToDifferentiate == variable else { return Polynomial(exponentiation: self as! Polynomial<NumberType>.ExponentiationType) }
        let exponentPriorToDifferentiation = self.exponent
        let exponent = exponentPriorToDifferentiation - 1
        guard exponent > 0 else {
            // actually this is never used.... but makes us able to distinguish between
            // doing `exponentiations.append(exponentiation)` and doing
            // nothing in differentiation in TermProtocol
            return Polynomial(constant: NumberType.one)
        }

        let exponentiation = Polynomial.ExponentiationType(variable, exponent: exponent)
        let term = Polynomial.TermType(exponentiation: exponentiation, coefficient: exponentPriorToDifferentiation)
        return Polynomial(term: term)
    }

}
