import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(SpearDatesTests.allTests),
        ]
    }
#endif
