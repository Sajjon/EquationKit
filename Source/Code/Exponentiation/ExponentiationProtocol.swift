//
//  ExponentiationProtocol.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol ExponentiationProtocol: Differentiatable, Algebraic, Comparable
    where
    PolynomialType.TermType.ExponentiationType == Self,
    PolynomialType.NumberType == Self.NumberType
{
    var variable: VariableType { get }
    var exponent: NumberType { get }
    init(variable: VariableType, exponent: NumberType)
}

// MARK: - Convenience Initializers
public extension ExponentiationProtocol {
    init(_ variable: VariableType, exponent: NumberType = .one) {
        self.init(variable: variable, exponent: exponent)
    }

    init(_ name: String, exponent: NumberType = .one) {
        self.init(VariableType(name), exponent: exponent)
    }
}


