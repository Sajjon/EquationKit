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

    func testFoo() {
        let eq: Equation = [2, ＋, 3, ·, 5]
        let rpn = reversePolishNotationFrom(infix: eq.infix)
        let tmp = rpn.compactMap { OperandOrOperator(token: $0) }
        let infix = ReversePolishNotation.toInfixFrom(rpn: tmp)
        let eq2 = Equation(infix: infix)

        print(eq2.description)

        guard let a = eq.numericSolution(), let b = eq2.numericSolution() else {
            XCTFail()
            return
        }

        XCTAssertEqual(a, b)
        XCTAssertEqual(17, a)
        XCTAssertEqual(17, b)
    }
}
