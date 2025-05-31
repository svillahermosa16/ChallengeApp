//
//  NetworkService.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation
import Network

class NetworkService {
    
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "networkMonitor")
    var isConnected = true
    let decoder = JSONDecoder()
    
    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
    
    func request<T : Decodable>(apiRequest: APIRequest, responseType: T.Type) async throws -> T {
        do {
            guard isConnected else {
                throw APIError.noInternetConnection
            }
            
            guard let url = apiRequest.url else {
                throw APIError.badURL
            }
            
            var request = URLRequest(url: url)
            
            addHeaders(request: &request, apiRequest: apiRequest)
            request.httpMethod = apiRequest.method.rawValue
            
            if apiRequest.method == .post {
                request.httpBody = try apiRequest.parameters.encode()
            }
            
#if DEBUG
            print("URL:\(String(describing: request.url?.absoluteString))")
#endif
            let (data, response) = try await URLSession.shared.data(for: request)
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            
            switch statusCode {
                
            case 200..<300:
                let model = try decoder.decode(responseType.self, from: data)
                return model
                
            case 401..<403:
                throw APIError.unauthorized
                
            default:
                let errorModel = try decoder.decode(ServerErrorResponse.self, from: data)
                throw APIError.badServerResponse(code: errorModel.code, message: errorModel.message)
            }
        }
    }
}

extension NetworkService {
    
    func addHeaders(request: inout URLRequest, apiRequest: APIRequest) {
        let headers = apiRequest.headers
        headers?.forEach {
            if request.value(forHTTPHeaderField: $0.key) == nil {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
                print($0.value)
            }
        }
    }
}




