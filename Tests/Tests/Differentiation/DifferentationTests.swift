//
//  DifferentationTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-12.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import XCTest
@testable import EquationKit

class DifferentationTests: BaseTest {

    override func setUp() {
        continueAfterFailure = false
    }

    func testDifferentation() {
        let equation = 3*(x^2) + (2*x)*y - (y^2)
        XCTAssertEqual(equation.differentiated(withRespectTo: x).description, "6*x + 2*y")
         XCTAssertEqual(equation.differentiated(withRespectTo: y).description, "2*x + 2*y")
    }
}
