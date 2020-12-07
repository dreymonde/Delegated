import XCTest

import DelegatedTests

var tests = [XCTestCaseEntry]()
tests += DelegatedTests.allTests()
XCTMain(tests)
