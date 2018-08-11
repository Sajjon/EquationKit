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
}
