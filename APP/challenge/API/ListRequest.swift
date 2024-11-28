//
//  ListRequest.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

struct ListRequest: APIRequest {
    typealias Response = ListResponse

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "search/repositories"
    }

    let query: String = "language:Java"
    let sort: String = "stars"

    var page: Int
    var perPage: Int = 30

    enum CodingKeys: String, CodingKey {
        case query = "q"
        case sort
        case page
        case perPage = "per_page"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(self.query, forKey: .query)
        try? container.encodeIfPresent(self.sort, forKey: .sort)
        try? container.encodeIfPresent(self.page, forKey: .page)
        try? container.encodeIfPresent(self.perPage, forKey: .perPage)
    }
}
