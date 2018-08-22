//
//  NumberExpressible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NumberExpressible: Numeric, Negatable, Hashable, Comparable {
    var isNegative: Bool { get }
    var isPositive: Bool { get }
    func absolute() -> Self
    static func mod(_ number: Self, modulus: Self, modulusMode: ModulusMode) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self

    static var zero: Self { get }
    static var one: Self { get }
    init(_ int: Int)
    init(_ double: Double)
}

public protocol FloatingPointNumberExpressible: NumberExpressible, BinaryFloatingPoint {
    init(_ float: Float)
}

public extension FloatingPointNumberExpressible {
    static func mod(_ number: Self, modulus: Self, modulusMode: ModulusMode) -> Self {
        return EquationKit.mod(number, modulus: number, modulusMode: modulusMode)
    }
}

extension Double: FloatingPointNumberExpressible {}
public extension Double {

    static var zero: Double { return 0 }
    static var one: Double { return 1 }

    var isNegative: Bool {
        return self < 0
    }

    var isPositive: Bool {
        return self > 0
    }

    func absolute() -> Double {
        return abs(self)
    }

    func negated() -> Double {
        return -self
    }
}
public protocol IntegerNumberExpressible: NumberExpressible, BinaryInteger {
    init(_ int: Int)
}

public extension IntegerNumberExpressible {
    static func mod(_ number: Self, modulus: Self, modulusMode: ModulusMode) -> Self {
        return EquationKit.mod(number, modulus: number, modulusMode: modulusMode)
    }
}
extension Int: IntegerNumberExpressible {}
public extension Int {

    static var zero: Int { return 0 }
    static var one: Int { return 1 }

    var isNegative: Bool {
        return self < 0
    }

    var isPositive: Bool {
        return self > 0
    }

    func absolute() -> Int {
        return abs(self)
    }

    func negated() -> Int {
        return -self
    }
}
