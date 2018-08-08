//
//  TestBase.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import XCTest
@testable import EquationKit

class TestBase: XCTestCase {

    func testEquation(expect expected: Int, equation: Equation) {
        guard let solution = equation.numericSolution() else { XCTFail("cant solve"); return }
        XCTAssertEqual(expected, solution)
    }

    func testEquation(expect expected: Int, infix: Token...) {
        testEquation(expect: expected, equation: Equation(infix: infix))
    }

    func testEquation(expect expected: Int, infix: Term...) {
        testEquation(expect: expected, equation: Equation(infix: infix))
    }

    func testEquation(expect expected: Int, infix: [Term]) {
        testEquation(expect: expected, equation: Equation(infix: infix))
    }
}
