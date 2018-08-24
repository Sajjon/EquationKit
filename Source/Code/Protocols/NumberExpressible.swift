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
    func mod(_ modulus: Self, modulusMode: ModulusMode) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self

    func raised(to exponent: Self) -> Self

    static var zero: Self { get }
    static var one: Self { get }
    init(_ int: Int)
    init(_ double: Double)
    init<F>(_ binaryFloatingPoint: F) where F: BinaryFloatingPoint
    init<I>(_ binaryInteger: I) where I: BinaryInteger

    var shortFormat: String { get }

}

public extension NumberExpressible {
    var isZero: Bool {
        return self == .zero
    }
}

public protocol FloatingPointNumberExpressible: NumberExpressible, BinaryFloatingPoint {
    init(_ float: Float)
}

public extension FloatingPointNumberExpressible {
    func mod(_ modulus: Self, modulusMode: ModulusMode) -> Self {
        return EquationKit.mod(self, modulus: modulus, modulusMode: modulusMode)
    }
}
extension Double: FloatingPointNumberExpressible {}
public extension Double {

    static var zero: Double { return 0 }
    static var one: Double { return 1 }
    var shortFormat: String {
        let decimalsEqualToZero = truncatingRemainder(dividingBy: 1) == 0
        let format = decimalsEqualToZero ? "%.0f" : "%.2f"
        return String(format: format, self)
    }

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

    func raised(to exponent: Double) -> Double {
        return pow(self, exponent)
    }
}
public protocol IntegerNumberExpressible: NumberExpressible, BinaryInteger {
    init(_ int: Int)
}

public extension IntegerNumberExpressible {
    func mod(_ modulus: Self, modulusMode: ModulusMode) -> Self {
        return EquationKit.mod(self, modulus: modulus, modulusMode: modulusMode)
    }
}
extension Int: IntegerNumberExpressible {}
public extension Int {

    static var zero: Int { return 0 }
    static var one: Int { return 1 }

    var shortFormat: String {
        return "\(self)"
    }

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


    func raised(to exponent: Int) -> Int {
        return Int(pow(Double(self), Double(exponent)))
    }
}
