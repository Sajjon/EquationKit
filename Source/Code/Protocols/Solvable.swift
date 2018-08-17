//
//  Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Solvable {
    func solve(constants: Set<Constant>, modulus: Double?, modulusMode: ModulusMode) -> Double?
}

public extension Solvable {
    func solve(constants: [Variable: Double], modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        return solve(constants: Set(constants.map { Constant($0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [Variable: Int], modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        return solve(constants: constants.mapValues { Double($0) }, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [String: Double], modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        return solve(constants: Set(constants.map { Constant($0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [String: Int], modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        return solve(constants: constants.mapValues { Double($0) }, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [Constant], modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard !constants.containsDuplicates() else { fatalError() }
        return solve(constants: Set(constants), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: Constant..., modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        return solve(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [Constant]) -> Double? {
        return solve(constants: assertingValue(), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> Constant) -> Double? {
        return solve(constants: [assertingValue()], modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [(Variable, Double)]) -> Double? {
        let array = assertingValue().map { Constant($0, value: $1) }
        return solve(constants: Set(array), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: @escaping () -> [(Variable, Int)]) -> Double? {
        return solve(modulus: modulus, modulusMode: modulusMode, assertingValue: { assertingValue().map { ($0.0, Double($0.1)) } })
    }
}
