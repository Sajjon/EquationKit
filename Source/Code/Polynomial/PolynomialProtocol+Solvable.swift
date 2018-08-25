//
//  PolynomialProtocol+Evaluatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Evaluatable
public extension PolynomialProtocol {
    func evaluate(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
        guard uniqueVariables.isSubset(of: constants.map { $0.toVariable() }) else { return nil }
        let solution = terms.reduce(constant, {
            guard let solution = $1.evaluate(constants: constants, modulus: modulus, modulusMode: modulusMode) else { return $0 }
            return $0 + solution
        })
        guard let modulus = modulus else { return solution }
        return solution.mod(modulus, modulusMode: modulusMode)
    }
}
