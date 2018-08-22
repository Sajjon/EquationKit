//
//  ExponentiationArraySortingTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-20.
//  Copyright © 2018 Sajjon. All rights reserved.
//
import Foundation
import XCTest
@testable import EquationKit

class ExponentiationArraySortingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testTrivial() {
        XCTAssertEqual([x², x³].sorted(by: .variablesAlphabetically), [x², x³])
        XCTAssertEqual([y², y³].sorted(by: .variablesAlphabetically), [y², y³])
        XCTAssertEqual([y², x³].sorted(by: .variablesAlphabetically), [x³, y²])
        XCTAssertEqual([x³, x²].sorted(by: .descendingExponent), [x³, x²])
        XCTAssertEqual([y², x³].sorted(by: .variablesAlphabetically), [x³, y²])
    }

    func testSortingAlphabetically() {
        XCTAssertEqual([z⁹, y⁹, x²].sorted(by: .variablesAlphabetically), [x², y⁹, z⁹])

    }

    func testSortingByExponent() {
        XCTAssertEqual([y², x³].sorted(by: .descendingExponent), [x³, y²])
    }


    func testSortingOfExponentiations() {

        let z100 = Exponentiation(z, exponent: 100)
        let x10 = Exponentiation(x, exponent: 10)

        let exponentiations: [Exponentiation] = [
            y⁷,
            x⁹,
            z⁹,
            x10,
            x⁸,
            z⁷,
            z100,
            x⁷,
            y⁸,
            z⁸,
            y⁹
        ]

        XCTAssertEqual(exponentiations.sorted(), [
            z100,
            x10,
            x⁹,
            y⁹,
            z⁹,
            x⁸,
            y⁸,
            z⁸,
            x⁷,
            y⁷,
            z⁷
            ])

        XCTAssertEqual(exponentiations.sorted(by: .descendingExponent), [
            z100,
            x10,
            x⁹,
            z⁹,
            y⁹,
            x⁸,
            y⁸,
            z⁸,
            y⁷,
            z⁷,
            x⁷
            ])

        XCTAssertEqual(exponentiations.sorted(by: .variablesAlphabetically), [
            x⁹,
            x10,
            x⁸,
            x⁷,
            y⁷,
            y⁸,
            y⁹,
            z⁹,
            z⁷,
            z100,
            z⁸
            ])
    }
}
