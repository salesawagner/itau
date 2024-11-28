//
//  DetailsViewModelSpy.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import XCTest
@testable import challenge

final class DetailsViewModelSpy: DetailsInputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    var viewController: DetailsOutputProtocol?
    var sectionTitle: String = ""

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func didTapReload() {
        receivedMessages.append(.didTapReload)
    }

    func pullToRefresh() {
        receivedMessages.append(.pullToRefresh)
    }

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }
}

extension DetailsViewModelSpy {
    enum Message {
        case didTapReload
        case pullToRefresh
        case viewDidLoad
    }
}
