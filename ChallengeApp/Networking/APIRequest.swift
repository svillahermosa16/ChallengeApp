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
    var suffix: String?
    private let baseUrlString = Constants.baseUrl

    var url: URL? {
        .init(string: retrieveFullPath())
    }

    init (path: RequestPath, method: HttpMethod, parameters: RequestParameters, headers: RequestHeaders? = nil, suffix: String? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.suffix = suffix
    }
    
    func retrieveFullPath() -> String {
        guard let base = URL(string: baseUrlString) else {
            return baseUrlString + path.rawValue
        }
        
        if !parameters.isEmpty {
            let components = urlComponents(params: parameters)
            guard var fullComponents = URLComponents(url: base, resolvingAgainstBaseURL: true) else {
                return base.absoluteString
            }
            
            fullComponents.path = fullComponents.path + components.path
            fullComponents.queryItems = components.queryItems
            
            return fullComponents.url?.absoluteString ?? base.absoluteString
        }
        
        var url = base.appendingPathComponent(path.rawValue)
        
        if let suffix = suffix {
            url = url.appendingPathComponent(suffix)
        }
        
        return url.absoluteString
    }

    func urlComponents(params: RequestParameters) -> URLComponents {
        var components = URLComponents()
        components.path = path.rawValue
        components.queryItems = params.compactMap { element -> URLQueryItem? in
            guard let value = element.value else { return nil }
            return URLQueryItem(name: element.key, value: String(describing: value))
        }
        return components
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
