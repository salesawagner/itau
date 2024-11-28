//
//  ListResponse.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

struct ListResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let repositories: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repositories = "items"
    }
}

struct Repository: Codable {
    let id: Int
    let name: String?
    let fullName: String?
    let owner: Owner
    let description: String?
    let forksCount: Int
    let starsCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case description
        case forksCount = "forks_count"
        case starsCount = "stargazers_count"
    }
}
