//
//  Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation


public protocol Solvable: NumberTypeSpecifying {
    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType?
}

public extension Solvable {

    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [ConstantStruct<NumberType>], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        guard !constants.containsDuplicates() else { fatalError() }
        return solve(constants: Set(constants), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: ConstantStruct<NumberType>..., modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [ConstantStruct<NumberType>]) -> NumberType? {
        return solve(constants: assertingValue(), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> ConstantStruct<NumberType>) -> NumberType? {
        return solve(constants: [assertingValue()], modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [VariableStruct<NumberType>: NumberType], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: Set(constants.map { ConstantStruct<NumberType>(variable: $0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [(VariableStruct<NumberType>, NumberType)]) -> NumberType? {
        let array = assertingValue().map { ConstantStruct<NumberType>(variable: $0, value: $1) }
        return solve(constants: Set(array), modulus: modulus, modulusMode: modulusMode)
    }
}
