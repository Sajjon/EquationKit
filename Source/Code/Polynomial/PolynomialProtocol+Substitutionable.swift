//
//  PolynomialProtocol+Substitutionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Substitutionable
public extension PolynomialProtocol {

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return Set(terms.flatMap { Array($0.uniqueVariables) })
    }

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>?) -> PolynomialType<NumberType> {
        return parseMany(
            substitutionables: terms,
            constants: constants,
            modulus: modulus,
            manyHandleAllNumbers: { values in
                values.reduce(self.constant, { $0 + $1 })
        },
            manyHandleMixedReduce: (initialResult: PolynomialType<NumberType>(constant: NumberType.zero), combine: {
                $0.adding(other: $1)
            })
        )
    }
}
