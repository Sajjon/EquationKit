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

        let nextPartialResult = { (accumulatingValue: Atom, nextElement: Substitution<NumberType>) -> Atom in
            return PolynomialType<NumberType>(accumulatingValue).multipliedBy(other: PolynomialType<NumberType>(nextElement.asAtom)) as Atom
        }

        return parseMany(
            substitutionables: exponentiations,
            constants: constants,
            modulus: modulus,
            modulusMode: modulusMode,
            manyHandleAllNumbers: { values in
                return values.reduce(NumberType.one, { $0 * $1 }) * coefficient
            },
            manyHandleMixedReduce: (initialResult: Self.atom1, combine: nextPartialResult)
        )
    }
}

internal extension TermProtocol {
    static var atom1: Atom { return PolynomialStruct<Self>(constant: .one) as Atom }
}
