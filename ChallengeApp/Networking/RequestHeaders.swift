//
//  File.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//


typealias RequestHeaders = [String: String]

extension RequestHeaders {
    static func baseAuthInit() -> RequestHeaders {
        var headers: RequestHeaders = [:]
        headers["Authorization"] = Constants.authToken
        return headers
    }
}
