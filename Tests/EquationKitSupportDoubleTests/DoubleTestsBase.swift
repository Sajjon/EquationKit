//
//  DoubleTestsBase.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit
@testable import EquationKitDoubleSupport

class DoubleTestsBase: XCTestCase {

    lazy var tx = Term(x)
    lazy var －tx = tx.negated()

    lazy var ty = Term(y)
    lazy var －ty = ty.negated()

    lazy var tz = Term(z)
    lazy var －tz = tz.negated()

    lazy var tx² = Term(exponentiation: x²)
    lazy var －tx² = tx².negated()

    lazy var ty² = Term(exponentiation: y²)
    lazy var －ty² = ty².negated()

    lazy var tz² = Term(exponentiation: z²)
    lazy var －tz² = tz².negated()

    lazy var tx³ = Term(exponentiation: x³)
    lazy var －tx³ = tx³.negated()

    lazy var ty³ = Term(exponentiation: y³)
    lazy var －ty³ = ty³.negated()

    lazy var tz³ = Term(exponentiation: z³)
    lazy var －tz³ = tz³.negated()

    lazy var tx⁴ = Term(x⁴)

    lazy var txyz = Term(x, y, z)
    lazy var －txyz = txyz.negated()

    lazy var txy = Term(x, y)
    lazy var －txy = txy.negated()
    lazy var txz = Term(x, z)
    lazy var －txz = txz
    lazy var tx²z³ = Term(x², z³)
    lazy var －tx²z³ = tx²z³.negated()
    lazy var tx²y²z² = Term(x², y², z²)
    lazy var －tx²y²z² = tx²y²z².negated()
    lazy var tx²y²z³ = Term(x²,y²,z³)
    lazy var －tx²y²z³ = tx²y²z³.negated()

}
