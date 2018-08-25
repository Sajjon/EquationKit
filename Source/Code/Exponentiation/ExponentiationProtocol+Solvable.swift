//
//  ExponentiationProtocol+Evaluatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Evaluatable
public extension ExponentiationProtocol {
    func evaluate(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
        guard let base = variable.evaluate(constants: constants, modulus: modulus, modulusMode: modulusMode) else { return nil }
        let value = base.raised(to: exponent)
        guard let modulus = modulus else { return value }
        return value.mod(modulus, modulusMode: modulusMode)
    }
}
