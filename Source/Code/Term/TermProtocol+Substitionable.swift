//
//  TermProtocol+Substitionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Substitionable
public extension TermProtocol {

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return Set(exponentiations.map { $0.variable })
    }

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>?) -> PolynomialType<NumberType> {
        return parseMany(
            substitutionables: exponentiations,
            constants: constants,
            modulus: modulus,
            manyHandleAllNumbers: { values in
                values.reduce(NumberType.one, { $0 * $1 }) * coefficient
            },
            manyHandleMixedReduce: (initialResult: PolynomialType<NumberType>(constant: coefficient), combine: {
                PolynomialType<NumberType>($0).multipliedBy(other: PolynomialType<NumberType>($1))
            })
        )
    }
}
