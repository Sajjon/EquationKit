//
//  ExponentiationProtocol+Concrete.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - ExponentiationStruct
public struct ExponentiationStruct<Number: NumberExpressible>: ExponentiationProtocol {

    public typealias NumberType = Number
    public typealias VariableType = VariableStruct<Number>
    public typealias PolynomialType = PolynomialStruct<Number>

    public let variable: VariableType
    public let exponent: NumberType

    public init(variable: VariableType, exponent: NumberType) {
        self.variable = variable
        self.exponent = exponent
    }
}
