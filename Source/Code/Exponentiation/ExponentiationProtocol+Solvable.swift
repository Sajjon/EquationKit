//
//  ExponentiationProtocol+Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Solvable
public extension ExponentiationProtocol {
    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
        guard let matchingVariable = constants.first(where: { $0.toVariable() == variable }) else { return nil }
        let value = matchingVariable.value.raised(to: exponent)
        guard let modulus = modulus else { return value }
        return value.mod(modulus, modulusMode: modulusMode)
    }
}
