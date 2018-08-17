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

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testSortingOfTerms() {
        XCTAssertEqual((2*x*y + 3*x + 5*y).description, "2xy + 3x + 5y")
    }

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

        let y＇ = eq.differentiateWithRespectTo(x)!
        XCTAssertEqual(42*x + 8*y - 50, y＇)
        XCTAssertEqual(
            0,
            y＇.solve() {[
                x <- 1,
                y <- 1
                ]}
        )

        let x＇ = eq.differentiateWithRespectTo(y)!
        XCTAssertEqual(8*x - 90*y + 268, x＇)
        XCTAssertEqual(
            0,
            x＇.solve() {[
                x <- 11.5,
                y <- 4
            ]}
        )
    }

    func testXMinusX() {
        XCTAssertEqual(x-x, Polynomial(0))
    }

    func testX²MinusX²() {
        XCTAssertEqual(x²-x², Polynomial(0))
    }

    func testXTimesXMinusXTimesX() {
        XCTAssertEqual(x*x-x*x, Polynomial(0))
    }

    func test2XMinusXTwice() {
        XCTAssertEqual(2*x-x-x, Polynomial(0))
    }

    func testConcatenation() {
        let term = Term(x)
        let polynomial = Polynomial(variable: y)
        let eq1 = term + polynomial
        XCTAssertEqual(eq1, x+y)
        let exponentiation = Exponentiation(x, exponent: 2)
        let eq2 = exponentiation + polynomial
        XCTAssertEqual(eq2, x²+y)

        let eq3 = term - polynomial
        XCTAssertEqual(eq3, x-y)
        let eq4 = exponentiation - polynomial
        XCTAssertEqual(eq4, x²-y)
    }

    func testFourRoots() {

        let roots2Factorized = (x-2)*(x+3)
        let roots2Expanded = x² + x - 6

        XCTAssertEqual(roots2Factorized, roots2Expanded)

        let roots3FromRoots2FactorizedLHS = roots2Factorized * (x+7)
        let roots3FromRoots2FactorizedRHS = (x+7) * roots2Factorized

        let roots3ExpanedManual = x³ + 8*x² + x - 42
        XCTAssertEqual(roots3FromRoots2FactorizedLHS, roots3ExpanedManual)
        XCTAssertEqual(roots3FromRoots2FactorizedRHS, roots3ExpanedManual)

        let roots3FactorizedManual = (x-2)*(x+3)*(x+7)
        XCTAssertEqual(roots3ExpanedManual, roots3FactorizedManual)

        let roots4FromRoots3FactorizedLHS = roots3FromRoots2FactorizedLHS * (x-11)
        let roots4FromRoots3FactorizedRHS = (x-11) * roots3FromRoots2FactorizedLHS

        let eq = (x-2)*(x+3)*(x+7)*(x-11)

        XCTAssertEqual(eq, roots4FromRoots3FactorizedLHS)
        XCTAssertEqual(eq, roots4FromRoots3FactorizedRHS)

        XCTAssertEqual(eq, x⁴ + 3*x³ - 87*x² - 53*x + 462)
        let solutions = [
            eq.solve() { x <- 2 },
            eq.solve() { x <- -3 },
            eq.solve() { x <- -7 },
            eq.solve() { x <- 11 }
        ]
        solutions.forEach {
            XCTAssertEqual($0, 0)
        }
    }
}
