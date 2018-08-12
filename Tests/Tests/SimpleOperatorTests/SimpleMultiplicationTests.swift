//
//  SimpleMultiplicationTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import XCTest
@testable import EquationKit

class SimpleMultiplicationTests: BaseTest {

    override func setUp() {
        continueAfterFailure = false
    }

    func testBasicMul() {
        func _eval(_ expression: () -> Expression) {
            eval(expected: "30 * x", expression)
        }

        _eval { 2 * 3 * x * 5 }
        _eval { 2 * x * 3 * 5 }
        _eval { (2 * x) * 3 * 5 }
        _eval { 2 * (x * 3) * 5 }
    }

    func testCase0() {
        deval("Mul(6, x)") { (2*x) * 3 }
    }

    func testCase1() {
        deval("Variable(x)") { (2*x) / 2 }
    }

    func testCase2() {
        deval("Variable(-x)") { (2*x) / (-2) }
    }

    func testCase3() {
        deval("Variable(-x)") { (-2*x) / 2 }
    }

    func testCase4() {
        deval("Variable(x)") { (-2*x) / (-2) }
    }

    func testCase6() {
        deval("Div(Mul(10, x), 3)") { (10 * x) / 3 }
    }

    func testCase7() {
        deval("Mul(2, x)") { (10 * x) / 5 }
    }

    func testCase8() {
        deval("Mul(5, x)") { (10 * x) / 2 }
    }
}
