//
//  APIRequest.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation

protocol APIRequestProtocol {
    func retrieveFullPath() -> String
    var method: HttpMethod { get }
    var parameters: RequestParameters { get }
    var path: RequestPath { get }
    var headers: RequestHeaders? { get }
}

struct APIRequest: APIRequestProtocol {
    
    let path: RequestPath
    let method: HttpMethod
    let parameters: RequestParameters
    var headers: RequestHeaders?
    
    private let baseUrlString = Constants.baseUrl

    var url: URL? {
        .init(string: retrieveFullPath())
    }

    init (path: RequestPath, method: HttpMethod, parameters: RequestParameters, headers: RequestHeaders? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
    func retrieveFullPath() -> String {
        guard let base = URL(string: baseUrlString) else {
            return baseUrlString + path.rawValue
        }
        
        let url = base.appendingPathComponent(self.path.rawValue)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return url.absoluteString
        }
        
        if !parameters.isEmpty {
            components.queryItems = parameters.compactMap { element -> URLQueryItem? in
                guard let value = element.value else { return nil }
                return .init(name: element.key, value: String(describing: value))
            }
        }
        return components.string ?? url.absoluteString
    }
    
    func urlComponents(params: RequestParameters) -> URLComponents {
        var components = URLComponents()
        components.path = path.rawValue
        components.queryItems = params.compactMap { element -> URLQueryItem? in
            guard let value = element.value else { return nil }
            return .init(name: element.key, value: String(describing: value))
        }
        return components
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
