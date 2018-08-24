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
    public typealias PolynomialType = PolynomialStruct<Number>

    public let variable: VariableStruct<NumberType>
    public let exponent: NumberType

    public init(variable: VariableStruct<NumberType>, exponent: NumberType) {
        self.variable = variable
        self.exponent = exponent
    }
}
