//
//  APITests.swift
//  APITests
//
//  Created by Wagner Sales
//

import XCTest
import API

final class APITests: XCTestCase {
    func test_list() throws {
        let expectation = XCTestExpectation(description: "test_list")
        let api = WASAPI(environment: Environment.local)
        api.send(ListRequest(page: 1)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.totalCount, 17040706)
                XCTAssertEqual(response.incompleteResults, true)

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func test_details() throws {
        let expectation = XCTestExpectation(description: "test_details")
        let api = WASAPI(environment: Environment.local)
        api.send(DetailsRequest(login: "", repository: "")) { result in
            switch result {
            case .success(let response):
                let pullRequest = response.first!

                XCTAssertFalse(pullRequest.title.isEmpty)
                XCTAssertFalse(pullRequest.body?.isEmpty ?? true)

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
