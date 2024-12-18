//
//  MBError.swift
//  API
//
//  Created by Wagner Sales
//

import Foundation

public enum APIError: Error {
    case badUrl
    case decoding(error: DecodingError)
    case unknown(error: Error, statusCode: Int)
    case invalidParam
    case invalidResponse
    case statusCode(_ code: Int)
    case server(message: String)
}
