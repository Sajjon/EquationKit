import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ConcatenationByAdditionTests.allTests),
        testCase(ConcatenationByMultiplicationTests.allTests),
        testCase(ConcatenationBySubtractionTests.allTests),
        testCase(SimpleDifferentiationTests.allTests),
        testCase(ConstantSubstitutionTests.allTests),
        testCase(ExploringRandomStuffTests.allTests),
        testCase(ExponentiationArraySortingTests.allTests),
        testCase(PolynomialMultipliedByPolynomialTests.allTests),
        testCase(PolynomialsExponentiatedTests.allTests),
        testCase(TermSortingTests.allTests),
    ]
}
#endif
