//
//  BigIntAdditionTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-25.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit
import BigInt

class BigIntAdditionTests: BigIntTestsBase {
    func testSimpleBigIntTests() {
        let f = BigInt("F", radix: 16)!
        let c = BigInt("C", radix: 16)!
        XCTAssertEqual(f-c, 3)
        XCTAssertEqual(f+c, 27)
    }

    func testAddition() {
        XCTAssertEqual((x + y).solve() {[ x <- 1 << 65, y <- 1 << 66 ]}, "110680464442257309696")
    }

    func testBigExp() {
        XCTAssertEqual((x⁹ + 1).solve() { x <- 1 << 65 }, "126633165554229521438977290762059361297987250739820462036000284719563379254544315991201997343356439034674007770120263341747898897565056619503383631412169301973302667340133957633")
    }
}
