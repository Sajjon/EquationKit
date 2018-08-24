//
//  Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation


public protocol Solvable: VariableTypeSpecifying, NumberTypeSpecifying where Self.NumberType == Self.VariableType.NumberType {
    func solve(constants: Set<ConstantStruct<VariableType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType?
}

public extension Solvable {

    func solve(constants: Set<ConstantStruct<VariableType>>, modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [String: NumberType], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: Set(constants.map { ConstantStruct<VariableType>(name: $0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [String: Int], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants.mapValues { NumberType($0) }, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [ConstantStruct<VariableType>], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        guard !constants.containsDuplicates() else { fatalError() }
        return solve(constants: Set(constants), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: ConstantStruct<VariableType>..., modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [ConstantStruct<VariableType>]) -> NumberType? {
        return solve(constants: assertingValue(), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> ConstantStruct<VariableType>) -> NumberType? {
        return solve(constants: [assertingValue()], modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [VariableType: NumberType], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: Set(constants.map { ConstantStruct<VariableType>(variable: $0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [VariableType: Int], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants.mapValues { NumberType($0) }, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [(VariableType, NumberType)]) -> NumberType? {
        let array = assertingValue().map { ConstantStruct<VariableType>(variable: $0, value: $1) }
        return solve(constants: Set(array), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: @escaping () -> [(VariableType, Int)]) -> NumberType? {
        return solve(modulus: modulus, modulusMode: modulusMode, assertingValue: { assertingValue().map { ($0.0, NumberType($0.1)) } })
    }

}
