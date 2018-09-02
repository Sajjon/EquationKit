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
            Polynomial(eq.substitute() {[ y <- 2 ]}.asAtom)
        )
    }

}

