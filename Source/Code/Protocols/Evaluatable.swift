//
//  Evaluatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation



public protocol Evaluatable: NumberTypeSpecifying {
    var uniqueVariables: Set<VariableStruct<NumberType>> { get }
    func evaluate(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType?
}

public extension Evaluatable {

    func evaluate(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return evaluate(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func evaluate(constants: [ConstantStruct<NumberType>], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        guard !constants.containsDuplicates() else { fatalError() }
        return evaluate(constants: Set(constants), modulus: modulus, modulusMode: modulusMode)
    }

    func evaluate(constants: ConstantStruct<NumberType>..., modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return evaluate(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func evaluate(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [ConstantStruct<NumberType>]) -> NumberType? {
        return evaluate(constants: assertingValue(), modulus: modulus, modulusMode: modulusMode)
    }

    func evaluate(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> ConstantStruct<NumberType>) -> NumberType? {
        return evaluate(constants: [assertingValue()], modulus: modulus, modulusMode: modulusMode)
    }

    func evaluate(constants: [VariableStruct<NumberType>: NumberType], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return evaluate(constants: Set(constants.map { ConstantStruct<NumberType>($0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func evaluate(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [(VariableStruct<NumberType>, NumberType)]) -> NumberType? {
        let array = assertingValue().map { ConstantStruct<NumberType>($0, value: $1) }
        return evaluate(constants: Set(array), modulus: modulus, modulusMode: modulusMode)
    }
}