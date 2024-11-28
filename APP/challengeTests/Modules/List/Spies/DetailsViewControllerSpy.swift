//
//  DetailsViewControllerSpy.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import XCTest
@testable import challenge

final class DetailsViewControllerSpy: DetailsOutputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func setTitle(_ title: String) {
        receivedMessages.append(.setTitle)
    }

    func startLoading() {
        receivedMessages.append(.startLoading)
    }

    func success(dataSource: [DetailsRowViewModel]) {
        receivedMessages.append(.success)
        expectation?.fulfill()
    }

    func failure() {
        receivedMessages.append(.failure)
        expectation?.fulfill()
    }
}

extension DetailsViewControllerSpy {
    enum Message {
        case setTitle
        case startLoading
        case success
        case failure
    }
}
