//
//  ListViewControllerSpy.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import XCTest
@testable import challenge

final class ListViewControllerSpy: ListOutputProtocol {
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

    func requestSuccess(dataSource: [challenge.ListRowViewModel]) {
        receivedMessages.append(.requestSuccess)
        expectation?.fulfill()
    }

    func failure() {
        receivedMessages.append(.failure)
        expectation?.fulfill()
    }

    func updateSuccess(dataSource: [challenge.ListRowViewModel]) {
        receivedMessages.append(.updateSuccess)
        expectation?.fulfill()
    }
}

extension ListViewControllerSpy {
    enum Message {
        case setTitle
        case startLoading
        case requestSuccess
        case failure
        case updateSuccess
    }
}
