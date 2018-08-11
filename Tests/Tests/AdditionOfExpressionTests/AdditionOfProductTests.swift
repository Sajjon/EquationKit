//
//  AdditionOfProductTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import XCTest
@testable import EquationKit

class AdditionOfProductTests: BaseTest {

    override func setUp() {
        continueAfterFailure = false
    }

    func testBasicAddOfProducts() {
        eval(expected: "(5 * x)") { 2*x + 3*x }
        eval(expected: "((2 * x) + (3 * y))") { 2*x + 3*y }
        eval(expected: "(3 + (2 * x))") { 2 + (2 * x) + 1 }
    }
}
