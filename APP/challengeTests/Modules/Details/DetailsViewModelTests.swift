//
//  DetailsViewModelTests.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import XCTest
import API
@testable import challenge

final class DetailsViewModelTests: XCTestCase {
    private func makeSUT(api: APIClient, expectation: XCTestExpectation? = nil) -> (
        DetailsViewModel,
        DetailsViewControllerSpy
    ) {
        let viewControllerSpy = DetailsViewControllerSpy(expectation: expectation)
        let sut = DetailsViewModel(api: api, login: "", repository: "")
        sut.viewController = viewControllerSpy

        return (sut, viewControllerSpy)
    }

    // MARK: Tests

    func test_viewDidLoad_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "viewDidLoad_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.setTitle, .startLoading, .success])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_requestDetails_startLoading_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local))
        sut.viewDidLoad()

        XCTAssertEqual(viewControllerSpy.receivedMessages, [.setTitle, .startLoading])
    }

    func test_viewDidLoad_requestDetails_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetails_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_viewDidLoad_requestDetails_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetails_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_pullToRefresh_requestDetails_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetails_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.pullToRefresh()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_pullToRefresh_requestDetails_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetails_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.pullToRefresh()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_didTapReload_requestDetails_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetails_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.didTapReload()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_didTapReload_requestDetails_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetails_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.didTapReload()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }
}
