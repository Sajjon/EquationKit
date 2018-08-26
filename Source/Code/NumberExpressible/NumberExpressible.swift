//
//  NumberExpressible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NumberExpressible: Numeric, Negatable, Hashable, Comparable {

    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self


    func raised(to exponent: Self) -> Self
    func absolute() -> Self
    func mod(_ modulus: Self, modulusMode: ModulusMode) -> Self

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

