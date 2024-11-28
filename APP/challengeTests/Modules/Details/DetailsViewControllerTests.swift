//
//  DetailsViewControllerTests.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import XCTest
@testable import challenge

final class DetailsViewControllerTests: XCTestCase {
    private func makeSUT(expectation: XCTestExpectation? = nil) -> (
        sut: DetailsViewController,
        viewModel: DetailsViewModelSpy
    ) {
        let viewModelSpy = DetailsViewModelSpy(expectation: expectation)
        let sut = DetailsViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: DetailsViewController) {
        let window = UIWindow()
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

    func test_viewDidLoad_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.viewDidLoad])
    }

    func test_didTapReloadButton_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)

        sut.didTapReloadButton()
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didTapReload))
    }

    func test_pullToRefresh_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)

        sut.pullToRefresh()
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.pullToRefresh))
    }

    func test_failure_shouldReceiveCorrectMessages() {
        let (sut, _) = makeSUT()
        loadView(sut: sut)

        sut.failure()
        XCTAssertNotNil(sut.errorView)
    }
}
