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
        let infix = [﹙,﹙,15, ୵,﹙,7,－,﹙,1, ＋, 1,﹚,﹚,﹚, ·, 3,﹚,－,﹙,2, ＋,﹙,1, ＋, 1,﹚,﹚]
        testEquation(expect: 5, infix: infix)

    }

    func testExponentiationUsingShorthandNotation() {
        testEquation(expect: 4, infix: 2,²)
        testEquation(expect: 8, infix: 2,³)
        testEquation(expect: 16, infix: 2,⁴)
        testEquation(expect: 512, infix: 2,⁹)
        testEquation(expect: 1024, infix: 2,＾,10)
    }

    func testTermStaticShorthandOperators() {
         testEquation(expect: 5, infix: 2,², .＋, 1)
         testEquation(expect: 3, infix: 2,², .－, 1)
         testEquation(expect: 8, infix: 2,², .·, 2)
         testEquation(expect: 2, infix: 2,², .୵, 2)
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

    func testConversionToReversePolishAndBackToInfix() {
        let eq: Equation = [2, ＋, 3, ·, 5]
        let eq2 = Equation(infix: eq.toReversePolishNotation().toInfixNotation())
        XCTAssertEqual(eq, eq2)
    }

    func testUnaryAbs() {
        testEquation(expect: 2, equation: Equation.abs(-2))
    }

    func testTernaryOperationModInverse() {
        testEquation(expect: 2753, infix: .modInverse(1, 17, mod: 3120))
    }

    func testTernaryOperationModInverseLong() {
        testEquation(expect: 4, infix: .modInverse(1, 10, mod: 13))
        testEquation(expect: 4, infix: .modInverse(1, 10, mod: [10, ＋, 3]))
        testEquation(expect: 4, infix: .modInverse(1, 10, mod: 2,³,.＋, 5))
        testEquation(expect: 4, infix: .modInverse([3, －, 2], [2, ·, 3, ＋, 4], mod: 13))
    }

    func testTernaryOperationChained() {
        testEquation(expect: 5, infix: .modInverse(1, 10, mod: 7))
        testEquation(expect: 9, infix: .modInverse(1, 5, mod: 11))

        testEquation(expect: 9, infix: .modInverse(1, .modInverse(1, [2, ·, 5], mod: [8, －, 1]), mod: .sqrt([3, ·, 7, ＋, 10, ·, 10])))
    }
}
