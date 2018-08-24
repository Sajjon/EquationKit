//
//  ConcatenationByMultiplicationTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//


import Foundation
import XCTest
@testable import EquationKit

class ConcatenationByMultiplicationTests: DoubleTestsBase {

    func testX³() {
        let eq = x*x*x
        XCTAssertEqual(eq, x³ + 0)
        XCTAssertEqual(eq.solve() { x <- 2 }!, 8)
        XCTAssertEqual(eq.solve() { x <- 3 }!, 27)
        XCTAssertEqual(eq.solve() { x <- 4 }!, 64)
        XCTAssertEqual(eq.solve() { x <- 5 }!, 125)
    }

    // Testing different ways of expressiong `x*y*z`
    func testVariableTimesVariableTimesVariable() {
        let xy = x*y
        let yx = y*x
        XCTAssertEqual(xy, yx)
        let yz = y*z

        let xy_z = xy*z
        let yx_z = yx*z
        XCTAssertEqual(xy_z, yx_z)

        let x_yz = x*yz
        XCTAssertEqual(x_yz, xy_z)
        XCTAssertEqual(x_yz, yx_z)
        XCTAssertEqual(x*y*z, x_yz)
        XCTAssertEqual(x*y*z, x_yz)

        XCTAssertEqual(Term(exponentiation: x³), Term(x, x, x))
    }
}
