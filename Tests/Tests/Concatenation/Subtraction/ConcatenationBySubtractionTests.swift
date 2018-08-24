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
        XCTAssertEqual((y - x).asString(sorting: .coefficient), "y - x")
        XCTAssertEqual(x - x, x - x) // trivial
        XCTAssertEqual(x - y, x - y) // trivial
        XCTAssertEqual((x - y).asString(sorting: .coefficient), "x - y")
        print((x - y).asString(sorting: .coefficient))
        print((y - x).asString(sorting: .coefficient))
        XCTAssertNotEqual(x - y, y - x)
    }


    func testXMinusX() {
        XCTAssertEqual(x-x, 0)
    }

    func testX²MinusX²() {
        XCTAssertEqual(x²-x², 0)
    }

    func testXTimesXMinusXTimesX() {
        XCTAssertEqual(x*x-x*x, 0)
    }

    func test2XMinusXTwice() {
        XCTAssertEqual(2*x-x-x, 0)
    }

    func testVariableSubtractExponentiationAndReversed() {
        let 𝑥²－𝑥 = x² - x
        let 𝑥－𝑥² = x - x²
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- 2 }, 2)
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- -2 }, 6)
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- 3 }, 6)
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- -3 }, 12)
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- 4 }, 12)
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- -4 }, 20)
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- 5 }, 20)
        XCTAssertEqual(𝑥²－𝑥.solve() { x <- -5 }, 30)

        XCTAssertEqual(𝑥－𝑥².solve() { x <- 2 }, -2)
        XCTAssertEqual(𝑥－𝑥².solve() { x <- -2 }, -6)
        XCTAssertEqual(𝑥－𝑥².solve() { x <- 3 }, -6)
        XCTAssertEqual(𝑥－𝑥².solve() { x <- -3 }, -12)
        XCTAssertEqual(𝑥－𝑥².solve() { x <- 4 }, -12)
        XCTAssertEqual(𝑥－𝑥².solve() { x <- -4 }, -20)
        XCTAssertEqual(𝑥－𝑥².solve() { x <- 5 }, -20)
        XCTAssertEqual(𝑥－𝑥².solve() { x <- -5 }, -30 )

        XCTAssertNotEqual(x² - x, x - x²)
        XCTAssertNotEqual(x² - x, x² - y)
        XCTAssertNotEqual(x² - x, x³ - x)
    }


    func testVariableSubtractTermAndReversed() {
        let xy = x*y

        let 𝑥－𝑥𝑦 = x - xy
        XCTAssertEqual(𝑥－𝑥𝑦.solve() {[ x <- 5, y <- 3 ]}, -10)
        XCTAssertEqual(𝑥－𝑥𝑦.solve() {[ x <- 5, y <- -3 ]}, 20)
        XCTAssertEqual(𝑥－𝑥𝑦.solve() {[ x <- 6, y <- -4 ]}, 30)


        let 𝑥𝑦－𝑥 = xy-x
        XCTAssertEqual(𝑥𝑦－𝑥.solve() {[ x <- 5, y <- 3 ]}, 10)
        XCTAssertEqual(𝑥𝑦－𝑥.solve() {[ x <- 7, y <- 11 ]}, 70)

        XCTAssertNotEqual(x - xy, xy - x)
        XCTAssertNotEqual(x - xy, y - xy)
    }

    func testControlIfDuplicates() {
        let constants = [Constant(x, value: 3), Constant(y, value: 1)]
        XCTAssertFalse(constants.containsDuplicates())
    }

    func testVariableSubtractPolynomialAndReversed() {
        let eq = x - 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)

        XCTAssertNotEqual(x - eq, eq - x)
        XCTAssertNotEqual(x - eq, y - eq)

        XCTAssertEqual(x - eq, 2)
        XCTAssertEqual((y - eq).asString(sorting: .coefficient), "y - x + 2")
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

        XCTAssertNotEqual(x² - xy, xy - x²)
        XCTAssertNotEqual(y² - xy, xy - y²)
        XCTAssertEqual(x² - xy, x² - yx)
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

        XCTAssertEqual((xy - xz).asString(sorting: .coefficient), "xy - xz")
        XCTAssertEqual((xz - xy).asString(sorting: .coefficient), "xz - xy")
        XCTAssertEqual(xy - xz, x*(y - z))

        XCTAssertNotEqual(xy - xz, xz - xy)
    }

    func testTermSubtractPolynomialAndReversed() {
        let xy = x*y
        let xz = x*z
        let eq = x - 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        let eq2 = x - 3
        XCTAssertTrue(type(of: eq2) == Polynomial.self)

        XCTAssertEqual((xy - eq).asString(sorting: .coefficient), "xy - x + 2")
        XCTAssertEqual((eq - xy).asString(sorting: .coefficient), "x - xy - 2")

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

        XCTAssertEqual((eq - eq2).asString(sorting: .coefficient), "x - y + 1")
        XCTAssertEqual((eq2 - eq).asString(sorting: .coefficient), "y - x - 1")

        XCTAssertNotEqual(eq - eq2, eq2 - eq)
        XCTAssertNotEqual(eq - eq2, x - y - 5)
    }
}

