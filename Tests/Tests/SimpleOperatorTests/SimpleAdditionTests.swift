//
//  SimpleAdditionTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import XCTest
@testable import EquationKit

class SimpleAdditionTests: BaseTest {

    override func setUp() {
        continueAfterFailure = false
    }

    func testCase0() {
        deval("Add(x, 2)") { (x+1) + 1 }
    }

    func testCase1() {
        deval("Variable(x)") { (x+1) + (-1) }
    }

    func testCase2() {
        deval("Sub(x, 1)") { (x+1) + (-2) }
    }

    func testCase3() {
        deval("Variable(x)") { (x-1) + 1 }
    }

    func testCase4() {
        deval("Sub(2, x)") { (1-x) + 1 }
    }

    func testCase5() {
        deval("Add(x, 1)") { (x-1) + 2 }
    }

    func testCase6() {
        deval("Sub(x, 2)") { (x-1) + (-1) }
    }

    func testCase7() {
        deval("Variable(-x)") { (1-x) + (-1) }
    }

    func testCase8() {
        deval("Variable(x)") { (x+1) - 1 }
    }

    func testCase9() {
        deval("Add(x, 2)") { (x+1) - (-1) }
    }

    func testCase10() {
        deval("Sub(x, 2)") { (x-1) - 1 }
    }

    func testCase11() {
        deval("Variable(-x)") { (1-x) - 1 }
    }

    func testCase12() {
        deval("Variable(x)") { (x-1) - (-1) }
    }

    func testCase13() {
        deval("Sub(2, x)") { (1-x) - (-1) }
    }

    func testCase14() {
        deval("Add(x, 1)") { (x-1) - (-2) }
    }

    func testCase15() {
        deval("Add(x, 1)") { x - (-1) }
    }

    func testCase16() {
        deval("Sub(-1, x)") { (-1) - x }
    }

    func testCase17() {
        deval("Add(x, 1)") { 1 - (-x) }
    }

    func testCase18() {
        deval("Sub(1, x)") { 1 + (-x) }
    }

    func testCase19() {
        deval("Sub(-1, x)") { -1 + (-x) }
    }

    func testCase20() {
        deval("Sub(1, x)") { (-x) + 1 }
    }

    func testCase21() {
        deval("Sub(-1, x)") { (-x) - 1 }
    }

    func testCase22() {
        deval("Sub(-1, x)") { (-x) + -1 }
    }

    func testCase23() {
        deval("Sub(1, x)") { (-x) - (-1)  }
    }

    func testCase24() {
        deval("Variable(-x)") { 1 - (1 + x) }
    }

    func testCase25() {
        deval("Variable(x)") { 1 - (1 - x) }
    }

    func testCase26() {
        deval("Variable(x)") { 1 - (1 + -x) }
    }

    func testCase27() {
        deval("Variable(-x)") { 1 - (1 - -x) }
    }
}
