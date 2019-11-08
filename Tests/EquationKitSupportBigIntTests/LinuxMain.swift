import XCTest

import EquationKitSupportBigIntTests

var tests = [XCTestCaseEntry]()
tests += BigIntAdditionTests.allTests()
tests += MathematicalOperatorTests.allTests()
XCTMain(tests)
