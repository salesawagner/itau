//
//  DetailsRequest.swift
//  API
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

    var login: String
    var repository: String
}
