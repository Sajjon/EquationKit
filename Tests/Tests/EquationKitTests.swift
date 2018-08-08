//
//  EquationKitTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import XCTest
@testable import EquationKit

class EquationKitTests: TestBase {

    override func setUp() {
        continueAfterFailure = false
    }

    /// https://en.wikipedia.org/wiki/Reverse_Polish_notation#Example
    func testInfixToPostfixNotation() {
        testEquation(expect: 5, infix: ﹙,﹙,15, ୵,﹙,7,－,﹙,1, ＋, 1,﹚,﹚,﹚, ·, 3,﹚,－,﹙,2, ＋,﹙,1, ＋, 1,﹚,﹚)
    }

    func testExponentiationUsingShorthandNotation() {
        testEquation(expect: 8, infix: 2,³)
        testEquation(expect: 16, infix: 2,⁴)
        testEquation(expect: 512, infix: 2,⁹)
        testEquation(expect: 1024, infix: 2,＾,10)
    }

    func testModulus() {
        testEquation(expect: 0, infix: 60, ％, 60)
        testEquation(expect: 1, infix: 61, ％, 60)

        testEquation(expect: 4, infix: 2, ＾, 10, ％, 5)
    }

    func testAssociativity() {
        testEquation(expect: 17, infix: 2, ＋, 3, ·, 5)
        testEquation(expect: 24, infix: 2, ＋, 3, ·, 5, ＋, 7, ·, 11, ％, 10)
        testEquation(expect: 19, infix: 2, ＋, 3, ·, 5, ＋, ﹙, 7, ·, 11, ﹚, ％, 75)
    }
}
