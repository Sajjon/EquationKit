//
//  Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NumberTypeSpecifying {
    associatedtype NumberType: NumberExpressible
}

public protocol Solvable: NumberTypeSpecifying {
//    associatedtype NumberType: NumberExpressible
    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType?
}

public extension Solvable {

    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [Variable: NumberType], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: Set(constants.map { ConstantStruct<NumberType>(variable: $0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [Variable: Int], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants.mapValues { NumberType($0) }, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [String: NumberType], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: Set(constants.map { ConstantStruct<NumberType>(name: $0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [String: Int], modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive) -> NumberType? {
        return solve(constants: constants.mapValues { NumberType($0) }, modulus: modulus, modulusMode: modulusMode)
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

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [(Variable, NumberType)]) -> NumberType? {
        let array = assertingValue().map { ConstantStruct<NumberType>(variable: $0, value: $1) }
        return solve(constants: Set(array), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: NumberType? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: @escaping () -> [(Variable, Int)]) -> NumberType? {
        return solve(modulus: modulus, modulusMode: modulusMode, assertingValue: { assertingValue().map { ($0.0, NumberType($0.1)) } })
    }
}
