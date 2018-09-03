//
//  ConstantSubstitutionTests.swift
//  EquationKitDoubleTests
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

class ConstantSubstitutionTests: DoubleTestsBase {

    func testReplaceYWith2() {
        let eq = x + y
        XCTAssertEqual(
            x + 2,
            eq.substitute() {[ y <- 2 ]}
        )
    }

    func testWeierstrass() {
        let 𝑥 = Variable("𝑥")
        let 𝑦 = Variable("𝑦")
        let 𝑥³ = 𝑥^^3
        let 𝑦² = 𝑦^^2
        let 𝑎 = Variable("𝑎")
        let 𝑏 = Variable("𝑏")
        let eq = 𝑦² - 𝑥³ - 𝑎*𝑥 - 𝑏
        XCTAssertEqual(eq.substitute() {[ 𝑎 <- 0, 𝑏 <- 7 ]}, 𝑦² - 𝑥³ - 7)
    }

}

