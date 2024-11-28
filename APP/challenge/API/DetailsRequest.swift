//
//  DetailsRequest.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

struct DetailsRequest: APIRequest {
    typealias Response = [DetailsResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "repos/\(login)/\(repository)/pulls"
    }

    let state: String = "all"

    var login: String
    var repository: String

    enum CodingKeys: String, CodingKey {
        case state
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(self.state, forKey: .state)
    }
}
