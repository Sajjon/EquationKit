//
//  ConcatenationByAdditionTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

class ConcatenationByAdditionTests: DoubleTestsBase {

    // MARK: - Number
    func testNumberAddVariableAndReversed() {
        XCTAssertEqual(x + 2, 2 + x)
        XCTAssertEqual(x + 2.5, 2.5 + x)

        XCTAssertNotEqual(x + 2, y + 2)

        XCTAssertNotEqual(x + 0.5, 0.4 + x)
        XCTAssertNotEqual(x + 1, 2 + x)
    }

    func testNumberAddExponentiationAndReversed() {
        XCTAssertEqual(Exponentiation(x, exponent: 2), x²)

        XCTAssertEqual(1 + x², x² + 1) // Commutative
        XCTAssertEqual(1 + y², y² + 1) // Commutative
        XCTAssertEqual(1.5 + x², x² + 1.5) // Commutative

        XCTAssertNotEqual(1 + x², 1 + y²)
    }

    func testNumberAddTermAndReversed() {
        let xy = x*y
        let yx = y*x
        XCTAssertEqual(yx, xy) // Multiplication is commutative

        XCTAssertEqual(xy + 2, 2 + xy)
        XCTAssertEqual(xy + 2.5, 2.5 + xy)
    }

    func testNumberAddPolynomialAndReversed() {
        let eq = x + 2
        let eq2 = x + 5
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        XCTAssertTrue(type(of: eq2) == Polynomial.self)

        XCTAssertEqual(eq + 3, eq2)
        XCTAssertEqual(3 + eq, eq2)
        XCTAssertEqual(1 + eq + 2, eq2)
        XCTAssertEqual(1.5 + eq + 1.5, eq2)
    }

    // MARK: - Variable
    func testVariableAddVariable() {
        XCTAssertEqual(x + x, x + x) // trivial
        XCTAssertEqual(x + y, x + y) // trivial
        XCTAssertEqual(x + y, y + x) // commutative
    }

    func testVariableAddExponentiationAndReversed() {
        XCTAssertEqual(x² + x, x + x²) // Commutative
        XCTAssertNotEqual(x² + x, x² + y)
        XCTAssertNotEqual(x² + x, x³ + x)
    }

    func testVariableAddTermAndReversed() {
        let xy = x*y
        XCTAssertEqual(x + xy, xy + x) // Commutative
        XCTAssertNotEqual(x + xy, y + xy)
    }

    func testVariableAddPolynomialAndReversed() {
        let eq = x + 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)

        XCTAssertEqual(x + eq, eq + x) // Commutative
        XCTAssertNotEqual(x + eq, y + eq)
    }

    // MARK: - Exponentiation
    func testExponentiationAddExponentiation() {
        XCTAssertEqual(x² + y², y² + x²) // Commutative
        XCTAssertEqual(x³ + y², y² + x³) // Commutative
        XCTAssertEqual(x² + y³, y³ + x²) // Commutative
        XCTAssertNotEqual(x² + y², x² + y³)
    }

    func testExponentiationAddTermAndReversed() {
        let xy = x*y
        let yx = y*x
        XCTAssertEqual(x² + xy, xy + x²) // Commutative
        XCTAssertEqual(y² + xy, xy + y²) // Commutative
        XCTAssertEqual(x² + xy, x² + yx) // Commutative
        XCTAssertNotEqual(x² + xy, y² + xy)
    }

    func testExponentiationAddPolynomialAndReversed() {
        let eq = x + 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        XCTAssertEqual(x² + eq, eq + x²)
        XCTAssertEqual(y² + eq, eq + y²)
        XCTAssertNotEqual(x² + eq, y² + eq)
    }

    // MARK: - Term
    func testTermAddTerm() {
        let xy = x*y
        let xz = x*z
        XCTAssertEqual((xy + xz).asString(sorting: TermSorting(betweenTerms: .termsAlphabetically)), "xy + xz")
        XCTAssertEqual((xz + xy).asString(sorting: TermSorting(betweenTerms: .termsAlphabetically)), "xy + xz")
        XCTAssertEqual(xy + xz, xz + xy) // Commutative
    }

    func testTermAddPolynomialAndReversed() {
        let xy = x*y
        let xz = x*z
        let eq = x + 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        let eq2 = x + 3
        XCTAssertTrue(type(of: eq2) == Polynomial.self)

        XCTAssertEqual(xy + eq, eq + xy) // Commutative
        XCTAssertNotEqual(xy + eq, xz + eq) // Commutative
        XCTAssertNotEqual(xy + eq, xy + eq2)
    }

    // MARK: - Polynomial
    func testPolynomialAddPolynomial() {
        let eq = x + 2
        XCTAssertTrue(type(of: eq) == Polynomial.self)
        let eq2 = y + 3
        XCTAssertTrue(type(of: eq2) == Polynomial.self)
        XCTAssertEqual(eq + eq2, eq2 + eq) // Commutative
        XCTAssertEqual(eq + eq2, x + y + 5)
    }

    func test3x() {
        let eq = x + x + x
        XCTAssertEqual(eq.description, "3x")
    }
}

