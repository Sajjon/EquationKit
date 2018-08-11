//
//  AdditionOfDivisionTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import XCTest
@testable import EquationKit

class AdditionOfDivisionTests: BaseTest {

    override func setUp() {
        continueAfterFailure = false
    }

    func testBasicAdd() {
        eval(expected: "(2 / x)") { 1/x + 1/x }
        eval(expected: "x") { x/2 + x/2 }
    }
}
