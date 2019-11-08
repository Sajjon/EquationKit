//
//  Substitutionable+Evaluate.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public extension Substitutionable {

    func evaluate(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>? = nil) -> NumberType? {
        return substitute(constants: constants, modulus: modulus).asNumber
    }

    func evaluate(constants: [ConstantStruct<NumberType>], modulus: Modulus<NumberType>? = nil) -> NumberType? {
        guard !constants.containsDuplicates() else { fatalError("cannot contain duplicates") }
        return evaluate(constants: Set(constants), modulus: modulus)
    }

    func evaluate(constants: ConstantStruct<NumberType>..., modulus: Modulus<NumberType>? = nil) -> NumberType? {
        return evaluate(constants: constants, modulus: modulus)
    }

    func evaluate(modulus: Modulus<NumberType>? = nil, makeConstants: () -> [ConstantStruct<NumberType>]) -> NumberType? {
        return evaluate(constants: makeConstants(), modulus: modulus)
    }

    func evaluate(modulus: Modulus<NumberType>? = nil, makeConstants: () -> ConstantStruct<NumberType>) -> NumberType? {
        return evaluate(constants: [makeConstants()], modulus: modulus)
    }

    func evaluate(constants: [VariableStruct<NumberType>: NumberType], modulus: Modulus<NumberType>? = nil) -> NumberType? {
        return evaluate(constants: constants.map { ConstantStruct<NumberType>($0, value: $1) }, modulus: modulus)
    }

    func evaluate(modulus: Modulus<NumberType>? = nil, makeConstants: () -> [(VariableStruct<NumberType>, NumberType)]) -> NumberType? {
        let array = makeConstants().map { ConstantStruct<NumberType>($0, value: $1) }
        return evaluate(constants: array, modulus: modulus)
    }
}
