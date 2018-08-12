//
//  BaseTest.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

let x = Variable("x")
let y = Variable("y")

class BaseTest: XCTestCase {

    func evaluate(expected: String, expression: Expression) {
        XCTAssertEqual(expected, expression.description)
    }

    func eval(expected: String, _ expression: () -> Expression) {
        evaluate(expected: expected, expression: expression())
    }

    func eval(_ expected: String, expression: Expression) {
        evaluate(expected: expected, expression: expression)
    }

    func eval(_ expected: String, _ expression: () -> Expression) {
        eval(expected: expected, expression)
    }

    func debugEvaluate(expected: String, expression: Expression) {
        XCTAssertEqual(expected, expression.debugDescription)
    }

    func deval(expected: String, _ expression: () -> Expression) {
        debugEvaluate(expected: expected, expression: expression())
    }

    func deval(_ expected: String, expression: Expression) {
        debugEvaluate(expected: expected, expression: expression)
    }

    func deval(_ expected: String, _ expression: () -> Expression) {
        deval(expected: expected, expression)
    }
}
