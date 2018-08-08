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
    func testEquation(expect expected: Int, infix: Token...) {
        guard let solution = Equation(infix: infix).evaluate() else { XCTFail("cant solve"); return }
        XCTAssertEqual(expected, solution)
    }

    func testEquation(expect expected: Int, infix: Term...) {
        guard let solution = Equation(infix: infix).evaluate() else { XCTFail("cant solve"); return }
        XCTAssertEqual(expected, solution)
    }

    func testEquation(expect expected: Int, infix: [Term]) {
        guard let solution = Equation(infix: infix).evaluate() else { XCTFail("cant solve"); return }
        XCTAssertEqual(expected, solution)
    }
}
