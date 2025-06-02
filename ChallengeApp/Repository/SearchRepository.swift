//
//  SearchRepository.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation

protocol SearchRepositoryProtocol {
    func searchProduct(query: String) async throws  -> ProductSearchResponse
    func searchProductDetails(productId: String) async throws -> ProductDetail
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
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.unknown
        }
    }
    
    func searchProductDetails(productId: String) async throws -> ProductDetail {
        let request = APIRequest(path: .product, method: .get, parameters: [:], headers: .baseAuthInit(), suffix: productId)
        do {
            let productDetailData = try await service.request(apiRequest: request, responseType: ProductDetail.self)
            return productDetailData
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.unknown
        }
    }
    
}
