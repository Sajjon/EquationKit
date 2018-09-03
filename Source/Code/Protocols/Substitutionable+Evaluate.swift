//
//  Substitutionable+Evaluate.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public extension Substitutionable {

    func evaluate(constants: Set<Substitution<NumberType>>, modulus: Modulus<NumberType>? = nil) -> NumberType? {
        return substitute(with: constants, modulus: modulus).asNumber
    }

    func evaluate(constants: [Substitution<NumberType>], modulus: Modulus<NumberType>? = nil) -> NumberType? {
        guard !constants.containsDuplicates() else { fatalError("cannot contain duplicates") }
        return evaluate(constants: Set(constants), modulus: modulus)
    }

    func evaluate(constants: Substitution<NumberType>..., modulus: Modulus<NumberType>? = nil) -> NumberType? {
        return evaluate(constants: constants, modulus: modulus)
    }

    func evaluate(modulus: Modulus<NumberType>? = nil, makeConstants: () -> [Substitution<NumberType>]) -> NumberType? {
        return evaluate(constants: makeConstants(), modulus: modulus)
    }

    func evaluate(modulus: Modulus<NumberType>? = nil, makeConstants: () -> Substitution<NumberType>) -> NumberType? {
        return evaluate(constants: [makeConstants()], modulus: modulus)
    }
}
