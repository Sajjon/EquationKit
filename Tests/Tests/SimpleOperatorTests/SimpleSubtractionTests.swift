//
//  SimpleSubtractionTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import XCTest
@testable import EquationKit

class SimpleSubtractionTests: BaseTest {

    override func setUp() {
        continueAfterFailure = false
    }

    func testBasicSub() {

        func _eval(_ expression: () -> Expression) {
            eval(expected: "5 - x", expression)
        }

        _eval { 5 - x }
        _eval { 6 - 1 - x }
    }
}
