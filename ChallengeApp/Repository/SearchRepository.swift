//
//  SearchRepository.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation

protocol SearchRepositoryProtocol {
    func searchProduct(query: String) async throws  -> ProductSearchResponse
    func searchProductDetails(productId: String) async
}

class SearchRepository: SearchRepositoryProtocol {
    let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func searchProduct(query: String) async throws -> ProductSearchResponse {
        let request = APIRequest(path: .search, method: .get, parameters: .searchParametersInit(query: query), headers: .baseAuthInit())
        do {
            let productsData = try await service.request(apiRequest: request, responseType: ProductSearchResponse.self)
            return productsData
        } catch {
            throw error
        }
    }
    
    func searchProductDetails(productId: String) async {
        
    }
    
}
