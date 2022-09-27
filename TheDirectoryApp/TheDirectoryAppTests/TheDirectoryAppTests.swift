//
//  TheDirectoryAppTests.swift
//  TheDirectoryAppTests
//
//  Created by isha pathak on 25/07/22.
//

import XCTest
@testable import TheDirectoryApp

class TheDirectoryAppTests: XCTestCase {

    let mockListWebService = MockTestDataService()

    func testListWebServiceResponse() {
        let expectation = self.expectation(description: "Employee list expected here")
        mockListWebService.fetchEmployeeDetails(){ json, error in

            XCTAssertNil(error)
            guard json != nil else {
                XCTFail()
                return
            }
            do {
                XCTAssertNotNil(json)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
