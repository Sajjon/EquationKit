//
//  ExponentiationProtocol.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol ExponentiationProtocol: Algebraic, Comparable {
    var variable: VariableStruct<NumberType> { get }
    var exponent: NumberType { get }
    init(variable: VariableStruct<NumberType>, exponent: NumberType)
}

// MARK: - Convenience Initializers
public extension ExponentiationProtocol {
    init(_ variable: VariableStruct<NumberType>, exponent: NumberType = .one) {
        self.init(variable: variable, exponent: exponent)
    }

    init(_ name: String, exponent: NumberType = .one) {
        self.init(VariableStruct<NumberType>(name), exponent: exponent)
    }
}


