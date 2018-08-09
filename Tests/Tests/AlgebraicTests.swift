//
//  AlgebraicTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import XCTest
@testable import EquationKit

class AlgebraicTests: TestBase {

    override func setUp() {
        continueAfterFailure = false
    }

    private func _differentiate(equation: Equation, expected: Equation) {
        XCTAssertEqual(equation.differentiate(), expected)
    }

    func testDifferentiation𝑥²() {
        _differentiate(
            equation: [𝑥, ＾, 2],
            expected: [2, ·, 𝑥]
        )
    }

    func testDifferentiation𝑥³() {
        _differentiate(
            equation: [𝑥, ＾, 3],
            expected: [3, ·, 𝑥, ＾, 2]
        )
    }

//    func testDifferentiation𝑥²＋𝑥() {
//        _differentiate(
//            equation: [𝑥, ＾, 2, ＋, 𝑥],
//            expected: [2, ·, 𝑥, ＋, 1]
//        )
//    }

    ///      𝑦² = 𝑥³ + 𝑎𝑥 + 𝑏
//    func testEllipticCurveEquationDifferentiation() {
//        let terms: [Term] = [𝑦,², .－, 𝑎, .·, 𝑥,³, .＋, 𝑏]
//        let equation = Equation(infix: terms)
//        print(equation)
//        let yPrim = equation.differentiate()
//        print(yPrim)
//    }
}
