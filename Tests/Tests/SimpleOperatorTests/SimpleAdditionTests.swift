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

    func testBasicAdd() {
        func _eval(_ expression: () -> Expression) {
            eval(expected: "x + 6", expression)
        }

        _eval { 2 + 3 + x + 1 }
        _eval { 2 + (3 + x) + 1 }
        _eval { 2 + 3 + (x + 1) }
    }

    func testAddAndSub() {
        eval(expected: "-2 - x") {  3 - x - 5 }
        eval(expected: "1 - x") {  3 - x - 2 }
    }

    func testDivideAdd() {
        eval(expected: "x + 2") { 4 / 2 + x }
    }
}
