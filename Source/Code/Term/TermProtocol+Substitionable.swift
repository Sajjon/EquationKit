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

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Substitution<NumberType> {

        return parseMany(
            substitutionables: exponentiations,
            constants: constants,
            modulus: modulus,
            modulusMode: modulusMode,
            manyHandleAllNumbers: { values in
                values.reduce(.one, { $0 * $1 }) * coefficient
            },
            manyHandleMixedReduce: (initialResult: Self.atom1, combine: {
                Poly($0).multipliedBy(other: Poly($1))
            })
        )
    }
}

internal extension TermProtocol {
    static var atom1: Atom { return PolynomialStruct<Self>(constant: .one) as Atom }
}
