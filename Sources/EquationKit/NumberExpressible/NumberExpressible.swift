//
//  NumberExpressible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NumberExpressible: Numeric, Negatable, AbsoluteConvertible, Hashable, Comparable {

    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self

    var asInteger: Int { get }

    func raised(to exponent: Self) -> Self
    func mod(_ modulus: Self, mode: ModulusMode) -> Self

    static var zero: Self { get }
    static var one: Self { get }

    var isNegative: Bool { get }
    var isPositive: Bool { get }
    var shortFormat: String { get }
}

public extension NumberExpressible {
    var isZero: Bool {
        return self == .zero
    }
}

public extension NumberExpressible {
    func modIfNeeded(_ modulus: Modulus<Self>?) -> Self {
        guard let modulus = modulus else { return self }
        return mod(modulus.number, mode: modulus.mode)
    }
}
