//
//  DetailsResponse.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

enum DetailsState: String, Codable {
    case open
    case closed
    case all
}

struct DetailsResponse: Codable {
    let id: Int
    let title: String?
    let body: String?
    let owner: Owner
    let state: DetailsState

    enum CodingKeys: String, CodingKey {
        case id, title, body, state
        case owner = "user"
    }
}
