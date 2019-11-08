//
//  PolynomialEvaluationOperators.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Non special unicode char operators
public func == <N>(polynomial: PolynomialType<N>, evaluationOperand: EvaluationOperand<N>) -> Bool {
    return polynomial.evaluate(constants: evaluationOperand.constants) == evaluationOperand.reference
}
public func != <N>(polynomial: PolynomialType<N>, evaluationOperand: EvaluationOperand<N>) -> Bool {
    return !(polynomial == evaluationOperand)
}

// MARK: Special unicode char corresponding operators
infix operator ≠: AssignmentPrecedence
public func ≠ <N>(polynomial: PolynomialType<N>, evaluationProxy: EvaluationOperand<N>) -> Bool {
    return polynomial != evaluationProxy
}
