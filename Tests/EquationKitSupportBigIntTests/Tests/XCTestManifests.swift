import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BigIntAdditionTests.allTests),
        testCase(MathematicalOperatorTests.allTests)
    ]
}
#endif
