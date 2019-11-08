import XCTest

import EquationKitSupportDoubleTests

var tests = [XCTestCaseEntry]()
tests += ConcatenationByAdditionTests.allTests)
tests += ConcatenationByMultiplicationTests.allTests)
tests += ConcatenationBySubtractionTests.allTests)
tests += SimpleDifferentiationTests.allTests)
tests += ConstantSubstitutionTests.allTests)
tests += ExploringRandomStuffTests.allTests)
tests += ExponentiationArraySortingTests.allTests)
tests += PolynomialMultipliedByPolynomialTests.allTests)
tests += PolynomialsExponentiatedTests.allTests)
tests += TermSortingTests.allTests)
XCTMain(tests)
