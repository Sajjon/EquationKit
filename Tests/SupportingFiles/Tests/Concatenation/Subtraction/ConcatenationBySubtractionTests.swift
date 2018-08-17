//
//  ConcatenationBySubtractionTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

class ConcatenationBySubtractionTests: XCTestCase {

    // MARK: - Number
    func testNumberSubtractVariableAndReversed() {
        XCTAssertEqual(x - 2, x - 2) // trivial
        XCTAssertEqual(x - 2, x - 2.0)

        // Inequality because of lack of commutativity
        XCTAssertNotEqual(x - 2, 2 - x)
        XCTAssertNotEqual(x - 2.5, 2.5 - x)

        XCTAssertNotEqual(x - 2, y - 2)

        XCTAssertNotEqual(x - 0.5, 0.4 - x)
        XCTAssertNotEqual(x - 1, 2 - x)
    }

    func testNumberSubtractExponentiationAndReversed() {
        XCTAssertEqual(Exponentiation(x, exponent: 2), x²)

        XCTAssertEqual(1 - x², 1 - x²) // trivial
        XCTAssertEqual(1.0 - x², 1 - x²)

        // Inequality because of lack of commutativity
        XCTAssertNotEqual(1 - x², x² - 1)
        XCTAssertNotEqual(1 - y², y² - 1)
        XCTAssertNotEqual(1 - x², 1 - y²)
    }

    func testNumberSubtractTermAndReversed() {
        let xy = x*y
        let yx = y*x
        XCTAssertTrue(type(of: xy) == Term.self)
        XCTAssertEqual(yx, xy) // Multiplication is commutative

        XCTAssertEqual(xy - 2, xy - 2) // trivial

        // Inequality because of lack of commutativity
        XCTAssertNotEqual(xy - 2, 2 - xy)
    }

    func testNumberSubtractPolynomialAndReversed() {
        let eq = x + 2
        let eq2 = x + 5
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        XCTAssertTrue(type(of: eq2) == Polynomial.self)

        XCTAssertEqual(eq - 2, eq - 2) // trivial
        XCTAssertEqual(eq - 2, Polynomial(variable: x))
        XCTAssertEqual((eq - 3).description, "x - 1")

        // Inequality because of lack of commutativity
        XCTAssertNotEqual(3 - eq, eq2)
        XCTAssertNotEqual(1 - eq - 2, eq2)
        XCTAssertNotEqual(1.5 - eq - 1.5, eq2)
    }

    // MARK: - Variable
    func testVariableSubtractVariable() {
        XCTAssertEqual((y - x).description, "y - x")
        XCTAssertEqual(x - x, x - x) // trivial
        XCTAssertEqual(x - y, x - y) // trivial
        XCTAssertEqual((x - y).description, "x - y")
        XCTAssertNotEqual(x - y, y - x)
        XCTAssertEqual(x - x, 0)
    }

    func testVariableSubtractExponentiationAndReversed() {

        XCTAssertEqual((x² - x).description, "x² - x")
        XCTAssertEqual((x - x²).description, "x - x²")

        XCTAssertEqual(2, (x² - x).solve() { x <- 2 })
        XCTAssertEqual(6, (x² - x).solve() { x <- 3 })
        XCTAssertEqual(12, (x² - x).solve() { x <- 4 })

        XCTAssertNotEqual(x² - x, x - x²)
        XCTAssertNotEqual(x² - x, x² - y)
        XCTAssertNotEqual(x² - x, x³ - x)
    }


    func testVariableSubtractTermAndReversed() {
        let xy = x*y
        XCTAssertTrue(type(of: xy) == Term.self)

        XCTAssertEqual((x - xy).description, "x - xy")
        XCTAssertEqual((y*x - x).description, "xy - x")

        XCTAssertNotEqual(x - xy, xy - x)
        XCTAssertNotEqual(x - xy, y - xy)
    }

    func testVariableSubtractPolynomialAndReversed() {
        let eq = x - 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)

        XCTAssertNotEqual(x - eq, eq - x)
        XCTAssertNotEqual(x - eq, y - eq)

        XCTAssertEqual(x - eq, 2)
        XCTAssertEqual((y - eq).description, "y - x + 2")
        XCTAssertEqual((y - eq).solve() {[ x <- 3, y <- 1 ]}, 0)
    }

    // MARK: - Exponentiation
    func testExponentiationSubtractExponentiation() {
        XCTAssertEqual(x² - x², 0)
        XCTAssertEqual(x³ - x³, 0)
        XCTAssertEqual(y² - y², 0)
        XCTAssertEqual(y³ - y³, 0)

        XCTAssertNotEqual(x² - y², y² - x²)

        XCTAssertEqual((x² - y²).description, "x² - y²")
        XCTAssertNotEqual(x³ - y², y² - x³)
        XCTAssertEqual((x³ - y²).description, "x³ - y²")
        XCTAssertNotEqual(x² - y³, y³ - x²)
        XCTAssertNotEqual(x² - y², x² - y³)
    }


    func testExponentiationSubtractTermAndReversed() {
        let xy = x*y
        let yx = y*x
        XCTAssertTrue(type(of: xy) == Term.self)



        XCTAssertNotEqual(x² - xy, xy - x²)
        XCTAssertNotEqual(y² - xy, xy - y²)
        XCTAssertNotEqual(x² - xy, x² - yx)
        XCTAssertNotEqual(x² - xy, y² - xy)
    }

    func testExponentiationSubtractPolynomialAndReversed() {
        let eq = x - 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)

        XCTAssertEqual((x² - eq).description, "x² - x + 2")

        XCTAssertNotEqual(x² - eq, eq - x²)
        XCTAssertNotEqual(y² - eq, eq - y²)
        XCTAssertNotEqual(x² - eq, y² - eq)
    }

    // MARK: - Term
    func testTermSubtractTerm() {
        let xy = x*y
        let xz = x*z
        XCTAssertTrue(type(of: xy) == Term.self)
        XCTAssertTrue(type(of: xz) == Term.self)

        XCTAssertEqual((xy - xz).description, "xy - xz")
        XCTAssertEqual((xz - xy).description, "xz - xy")
        XCTAssertEqual(xy - xz, x*(y - z))

        XCTAssertNotEqual(xy - xz, xz - xy)
    }

    func testTermSubtractPolynomialAndReversed() {
        let xy = x*y
        let xz = x*z
        XCTAssertTrue(type(of: xy) == Term.self)
        XCTAssertTrue(type(of: xz) == Term.self)
        let eq = x - 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        let eq2 = x - 3
        XCTAssertTrue(type(of: eq2) == Polynomial.self)

        XCTAssertEqual((xy - eq).description, "xy - x + 2")
        XCTAssertEqual((eq - xy).description, "x - xy - 2")

        XCTAssertNotEqual(xy - eq, eq - xy)
        XCTAssertNotEqual(xy - eq, xz - eq)
        XCTAssertNotEqual(xy - eq, xy - eq2)
    }

    // MARK: - Polynomial
    func testPolynomialSubtractPolynomial() {
        let eq = x - 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        let eq2 = y - 3
        XCTAssertTrue(type(of: eq2) == Polynomial.self)

        XCTAssertEqual((eq - eq2).description, "x - y + 1")
        XCTAssertEqual((eq2 - eq).description, "y - x - 1")

        XCTAssertNotEqual(eq - eq2, eq2 - eq)
        XCTAssertNotEqual(eq - eq2, x - y - 5)
    }
}

