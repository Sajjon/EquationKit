//
//  PolynomialEvaluationSubtitutionOfVariablesToConstantsOperators.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Non special unicode char operators
infix operator <--: BitwiseShiftPrecedence
public func <-- <N>(number: N, constants: [ConstantStruct<N>]) -> NumberAndConstants<N> {
    return NumberAndConstants(number: number, constants: constants)
}

// MARK: Special unicode char corresponding operators
infix operator ↤: BitwiseShiftPrecedence
public func ↤ <N>(number: N, constants: [ConstantStruct<N>]) -> NumberAndConstants<N> {
    return number <-- constants
}
