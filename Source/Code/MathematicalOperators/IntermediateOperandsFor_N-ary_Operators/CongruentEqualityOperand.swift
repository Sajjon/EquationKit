//
//  CongruentEqualityOperand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct CongruentEqualityOperand<Number: NumberExpressible> {
    public let scalar: Number
    public let modulus: Modulus<Number>
    public let constants: Set<Substitution<Number>>

    public init(scalar: Number, modulus: Number, constants: Set<Substitution<Number>>) {
        self.scalar = scalar
        self.modulus = Modulus<Number>(modulus)
        self.constants = constants
    }
}

public extension CongruentEqualityOperand {
    public init(scalar: Number, modulusConstants: ModularEvaluationOperand<Number>) {
        self.init(scalar: scalar, modulus: modulusConstants.modulus, constants: modulusConstants.constants)
    }
}
