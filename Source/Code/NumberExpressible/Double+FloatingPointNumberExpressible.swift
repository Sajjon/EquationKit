//
//  Double+FloatingPointNumberExpressible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Double: FloatingPointNumberExpressible {
    public typealias NumberType = Double
    public var asConstant: NumberType? {
        return self
    }

}
public extension Double {

    static var zero: Double { return 0 }
    static var one: Double { return 1 }
    var shortFormat: String {
        let decimalsEqualToZero = truncatingRemainder(dividingBy: 1) == 0
        let format = decimalsEqualToZero ? "%.0f" : "%.2f"
        return String(format: format, self)
    }

    var asInteger: Int {
        return Int(exactly: self)!
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
