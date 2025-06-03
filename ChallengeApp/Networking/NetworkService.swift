//
//  NetworkService.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation
import Network

protocol NetworkServiceProtocol {
    func request<T: Decodable>(apiRequest: APIRequestProtocol, responseType: T.Type) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    
    let session: URLSessionProtocol
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "networkMonitor")
    var isConnected = true
    let decoder = JSONDecoder()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
        
    }
    
    func request<T : Decodable>(apiRequest: APIRequestProtocol, responseType: T.Type) async throws -> T {
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
            let (data, response) = try await session.data(for: request)
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
    
    func addHeaders(request: inout URLRequest, apiRequest: APIRequestProtocol) {
        let headers = apiRequest.headers
        headers?.forEach {
            if request.value(forHTTPHeaderField: $0.key) == nil {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
                print($0.value)
            }
        }
    }
}




