//
//  SimpleDifferentiationTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

func == (lhs: Double, rhs: Polynomial) -> Bool {
    return lhs == rhs.asNumber
}
func == (lhs: Polynomial, rhs: Double) -> Bool {
    return lhs.asNumber == rhs
}
func == (lhs: Int, rhs: Polynomial) -> Bool {
    return Double(lhs) == rhs
}
func == (lhs: Polynomial, rhs: Int) -> Bool {
    return lhs == Double(rhs)
}

class SimpleDifferentiationTests: DoubleTestsBase {

    /// y³x²
    func test𝑦³𝑥²() {
        let eq = (y³*x²)
        XCTAssertEqual((2*y³*x), eq.differentiateWithRespectTo(x)!)
        XCTAssertEqual((3*y²*x²), eq.differentiateWithRespectTo(y)!)
    }


    /// 3x² - 3y
    func test𝟛𝑥²－𝟛𝑦() {
        let eq = 3*x² - 3*y
        XCTAssertEqual((6*x), eq.differentiateWithRespectTo(x)!)
        XCTAssertTrue(-3 == eq.differentiateWithRespectTo(y)!)
    }

    /// 3y² - 3x
    func test𝟛𝑦²－𝟛𝑥() {
        let eq = 3*y² - 3*x
        XCTAssertTrue(-3 == eq.differentiateWithRespectTo(x)!)
        XCTAssertEqual((6*y), eq.differentiateWithRespectTo(y)!)
    }

    /// 12x² + y³ - 12xy
    func test𝟙𝟚𝑥²＋𝑦³－𝟙𝟚𝑥𝑦() {
        let eq = 12*x² + y³ - 12*x*y
        XCTAssertEqual(24*x - 12*y, eq.differentiateWithRespectTo(x)!)
        XCTAssertEqual(3*y² - 12*x, eq.differentiateWithRespectTo(y)!)
    }

    /// 3x² + 2xy - y²
    func test𝟛𝑥²＋𝟚𝑥𝑦－𝑦²() {
        let equationVerbose = 3*x^^2 + 2*x*y - y^^2
        let equation = 3*x² + 2*x*y - y²
        XCTAssertEqual(equationVerbose.description, equation.description)
        XCTAssertEqual(equationVerbose, equation)

        XCTAssertEqual(6*x + 2*y, equation.differentiateWithRespectTo(x)!)
        XCTAssertEqual(2*x - 2*y, equation.differentiateWithRespectTo(y)!)
    }

    /// 3x⁵y² + 13xy + 7x + 9y
    func test𝟛𝑥⁵𝑦²＋𝟙𝟛𝑥𝑦＋𝟟𝑥＋𝟡𝑦() {
        let equation = 3*x⁵*y² + 13*x*y + 7*x + 9*y
        XCTAssertEqual(15*x⁴*y² + 13*y + 7, equation.differentiateWithRespectTo(x)!)
        XCTAssertEqual(6*x⁵*y + 13*x + 9, equation.differentiateWithRespectTo(y)!)
    }

    func test𝟙𝟘𝑥＾𝟙𝟙－𝟜𝑥＾𝟙𝟙－𝟝𝑥＾𝟙𝟙＋𝟞·𝟠𝑥() {
        let eq = 10*x^^11 - 4*x^^11 - 5*x^^11 + 6*8*x
        XCTAssertEqual(eq, x^^11 + 48*x)
        let y＇ = eq.differentiateWithRespectTo(x)!
        XCTAssertEqual(11*x^^10 + 48, y＇)
        XCTAssertEqual(eq.evaluate() { x <- 1 }, 49)
        XCTAssertEqual(eq.evaluate() { x <- 2 }, 2048+96)
        XCTAssertEqual(y＇.evaluate() { x <- 1 }, 59)
        XCTAssertEqual(y＇.evaluate() { x <- 2 }, 11*1024+48)
    }

    func testDoubleDifferentationOf𝟝𝑦⁴𝑥³() {
        let eq = y⁵*x³

        let y＇ = eq.differentiateWithRespectTo(x)!
        XCTAssertEqual((3*y⁵*x²), y＇)

        let yy＇ = y＇.differentiateWithRespectTo(x)!
        XCTAssertEqual((6 * y⁵ * x), yy＇)

        let x＇ = eq.differentiateWithRespectTo(y)!
        XCTAssertEqual((5*y⁴*x³), x＇)

        let xx＇ = x＇.differentiateWithRespectTo(y)!
        XCTAssertEqual((20 * y³ * x³), xx＇)


        let xy＇ = x＇.differentiateWithRespectTo(x)!
        XCTAssertEqual(15*y⁴*x², xy＇)

        let yx＇ = y＇.differentiateWithRespectTo(y)!
        XCTAssertEqual(15*y⁴*x², xy＇)

        XCTAssertEqual(xy＇, yx＇)
    }
}
