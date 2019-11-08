//
//  ExploringRandomStuffTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit
@testable import EquationKitDoubleSupport

class ExploringRandomStuffTests: DoubleTestsBase {

    static var allTests = [
        ("testDifferenceOfConsecutiveSquares", testDifferenceOfConsecutiveSquares),
        ("testDifferenceOfConsecutiveCubes", testDifferenceOfConsecutiveCubes),
        ("testDifferenceOfConsecutivePowersOfFour", testDifferenceOfConsecutivePowersOfFour),
        ("testDifferenceOfConsecutivePowersOfFour", testDifferenceOfConsecutivePowersOfFour),
    ]

    func testDifferenceOfConsecutiveSquares() {
        var lastSquareDiff: Double? = nil
        let equation = x² - y²
        for i in 0..<1000 {
            let squareDiff = equation.evaluate() {[ x <- Double(i+1), y <- Double(i) ]}!
            defer { lastSquareDiff = squareDiff }
            guard let lastSquareDiff = lastSquareDiff else { continue }
            XCTAssertEqual(squareDiff - lastSquareDiff, 2)
        }
    }

    func testDifferenceOfConsecutiveCubes() {
        var list = [Double]()
        let hexagonalRightmostDigitsPattern: [Double] = [1, 7, 9, 7, 1]
        let equation = x³ - y³
        for i in 0..<1000 {
            let difference = equation.evaluate() {[ x <- Double(i+1), y <- Double(i) ]}!
            let modRes = mod(difference, modulus: 10)
            list.append(modRes)
            if list.count == hexagonalRightmostDigitsPattern.count {
                XCTAssertEqual(list, hexagonalRightmostDigitsPattern)
                list = []
            }
        }
    }

    func testDifferenceOfConsecutivePowersOfFour() {
        continueAfterFailure = false
        var lastDiff: Double? = nil

        var diffsMod10 = [Double]()
        // Let `mod₁₀ { X }` denote `mod(x, 10)`:

        // `x⁴ⁿ - x⁴ⁿ⁻⁴`
        // Apparently `mod₁₀ { n⁴ - (n-1)⁴ }` have a cyclic property of size 5, repeating the following pattern:
        let diffsMod10Pattern: [Double] = [5, 5, 5, 9, 1]

        var diffDiffsMod10 = [Double]()


        //  `mod₁₀ { (n⁴ - (n-1)⁴)  -  ((n-1)⁴ - (n-2)⁴) }` <=> `mod₁₀ { n⁴ - 2(n-1)⁴ + (n-2)⁴ }`  have a cyclic property of size 5, repeating the following pattern:
        let diffDiffsMod10Pattern: [Double] = [4, 0, 0, 4, 2]

        let eq1 = x⁴ - y⁴
        let eq2 = 8*(x³+x) // (x-1)^^4 - (x-1)^^4/

        for i in 5..<1000 {
            let cx = Constant(x, value: i+1)
            let cy = Constant(y, value: i)
            let constants = [cx, cy]

            let difference = eq1.evaluate(constants: constants)!

            defer { lastDiff = difference }
            guard let lastDiff = lastDiff else { continue }
            let diffDiff = difference - lastDiff

            let diffMod10 = mod(difference, modulus: 10)
            diffsMod10.append(diffMod10)
            let diffDiffMod10 = mod(diffDiff, modulus: 10)
            diffDiffsMod10.append(diffDiffMod10)

            if diffsMod10.count == diffsMod10Pattern.count {
                XCTAssertEqual(diffsMod10, diffsMod10Pattern)
                diffsMod10 = []
            }

            if diffDiffsMod10.count == diffDiffsMod10Pattern.count {
                XCTAssertEqual(diffDiffsMod10, diffDiffsMod10Pattern)
                diffDiffsMod10 = []
            }
        }
    }
}
