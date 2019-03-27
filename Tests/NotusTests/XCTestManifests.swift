import XCTest

#if !(os(macOS) || os(iOS) || os(watchOS) || os(tvOS))
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MusicNotationTests.allTests),
        testCase(UserPatchMapTests.allTests),
        testCase(FancyPlayerTests.allTests),
        testCase(DefaultPlayerTests.allTests),
    ]
}
#endif