//
//  Int+IntegerNumberExpressible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Int: IntegerNumberExpressible {
    public typealias NumberType = Int
    public var asConstant: NumberType? {
        return self
    }
}
public extension Int {

    static var zero: Int { return 0 }
    static var one: Int { return 1 }

    var shortFormat: String {
        return "\(self)"
    }

    var isNegative: Bool {
        return self < 0
    }

    var asInteger: Int {
        return self
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
