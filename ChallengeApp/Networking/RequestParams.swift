//
//  RequestParams.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation

typealias RequestParameters = [String: Any?]

extension RequestParameters {
    static func searchParametersInit(query: String) -> RequestParameters {
        var parameters: RequestParameters = [:]
        parameters["status"] = Constants.activeStatus
        parameters["site_id"] = Constants.siteId
        parameters["q"] = query
        parameters["limit"] = Constants.limit
        return parameters
    }
    
    func encode() throws -> Data? {
        return try JSONSerialization.data(withJSONObject: compactMapValues { $0 })
    }
}
