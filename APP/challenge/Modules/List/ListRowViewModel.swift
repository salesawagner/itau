//
//  ListRowViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

struct ListRowViewModel {
    let repository: RepositoryViewModel
    let owner: OwnerViewModel
}

struct RepositoryViewModel {
    let id: Int
    let name: String
    let description: String
    let forks: Int
    let stars: Int
}

struct OwnerViewModel {
    let id: Int
    let avatarURL: String
    let name: String
    let fullName: String
}
