//
//  RequestPath.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//


import Foundation

struct RequestPath: RawRepresentable, Sendable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

enum ChallengeAppPaths {
    case search
    
    var path: RequestPath {
        switch self {
        case .search:
            return .init(rawValue: "/products/search")
        }
    }
}
