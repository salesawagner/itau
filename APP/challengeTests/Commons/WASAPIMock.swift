//
//  WASAPIMock.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import Foundation
import API

final class WASAPIMock: APIClient {
    func send<T>(_ request: T, completion: @escaping ResultCallback<T.Response>) where T: APIRequest {
        completion(.failure(.invalidParam))
    }
}
