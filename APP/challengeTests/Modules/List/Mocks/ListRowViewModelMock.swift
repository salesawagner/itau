//
//  ListRowViewModelMock.swift
//  challengeTests
//
//  Created by Wagner Sales
//

@testable import challenge

extension ListRowViewModel {
    static var mock: ListRowViewModel {
        .init(
            repository: .init(id: 0, name: "", description: "", forks: 0, stars: 0),
            owner: .init(id: 0, avatarURL: "", name: "", fullName: "")
        )
    }
}

extension Array where Element == ListRowViewModel {
    static var mock: [ListRowViewModel] {
        [.mock]
    }
}
