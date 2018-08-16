//
//  PolynomialMultipliedByPolynomialTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

class PolynomialMultipliedByPolynomialTests: XCTestCase {

    func testGrade1Short() {
        let eq = ((4*x) + 9) * ((8*x) + (5*y))
        XCTAssertEqual(eq, 32*x² + 20*x*y + 72*x + 45*y)
    }

    func testGrade1Long() {
        let eq = (3*x + 5*y - 17) * (7*x - 9*y + 23)
        XCTAssertEqual(eq, 21*x² + 8*x*y - 50*x - 45*y² + 268*y - 391)
        XCTAssertEqual(
            0,
            eq.solve() {[
            x <- 4,
            y <- 1
        ]})

        let y＇ = eq.differentiateWithRespectTo(x)
        XCTAssertEqual(42*x + 8*y - 50, y＇)
        XCTAssertEqual(
            0,
            y＇.solve() {[
                x <- 1,
                y <- 1
                ]}
        )

        let x＇ = eq.differentiateWithRespectTo(y)
        XCTAssertEqual(8*x - 90*y + 268, x＇)
        XCTAssertEqual(
            0,
            x＇.solve() {[
                x <- 11.5,
                y <- 4
            ]}
        )
    }

}
