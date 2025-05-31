//
//  APIError.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

public struct ServerErrorResponse: Decodable, Equatable {
    public let code: String
    public let message: String
}

enum APIError: Error, Equatable {
    case badURL
    case badServerResponse(code: String, message: String)
    case cannotDecodeRawData
    case noInternetConnection
    case unauthorized
}
