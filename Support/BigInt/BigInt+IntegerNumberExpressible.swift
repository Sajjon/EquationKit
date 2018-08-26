//
//  BigInt+IntegerNumberExpressible.swift
//  EquationKitBigIntTests
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// https://github.com/attaswift/BigInt
import BigInt

// Do not include this line when you copy the contents of this file to your own project
@testable import EquationKit // This is only included since this file is used by EquationKitBigIntTests

extension BigInt: IntegerNumberExpressible {}
public extension BigInt {
    var isNegative: Bool {
        return self < 0
    }

    var isPositive: Bool {
        return self > 0
    }

    func absolute() -> BigInt {
        return BigInt(sign: .plus, magnitude: magnitude)
    }

    func raised(to exponent: BigInt) -> BigInt {
        guard exponent.bitWidth <= Int.bitWidth else { fatalError("to big") }
        return power(Int(exponent))
    }

    static var zero: BigInt {
        return 0
    }

    static var one: BigInt {
        return 1
    }

    var shortFormat: String {
        return description
    }

    func negated() -> BigInt {
        return BigInt(sign: sign == .plus ? .minus : .plus, magnitude: magnitude)
    }
}
