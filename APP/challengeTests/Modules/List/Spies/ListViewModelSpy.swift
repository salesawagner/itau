//
//  ListViewModelSpy.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import XCTest
@testable import challenge

final class ListViewModelSpy: ListInputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    var viewController: ListOutputProtocol?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }

    func didSelectRow(indexPath: IndexPath) {
        receivedMessages.append(.didSelecteRow)
    }

    func didTapReload() {
        receivedMessages.append(.didTapReload)
    }

    func pullToRefresh() {
        receivedMessages.append(.pullToRefresh)
    }

    func prefetchRows() {
        receivedMessages.append(.prefetchRows)
    }
}

extension ListViewModelSpy {
    enum Message {
        case viewDidLoad
        case didSelecteRow
        case didTapReload
        case pullToRefresh
        case prefetchRows
    }
}
