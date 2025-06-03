//
//  BadURLAPIRequest.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//

import Foundation

struct BadURLAPIRequest: APIRequestProtocol {
    func retrieveFullPath() -> String {
        return ""
    }
    var parameters: RequestParameters = [:]
    let path: RequestPath = .init(rawValue: "")
    let method: HttpMethod = .get
    let headers: RequestHeaders? = [:]
    
    var url: URL? {
        return nil
    }
}

struct ProductResponse: Codable {
    let id: Int
    let name: String
}

