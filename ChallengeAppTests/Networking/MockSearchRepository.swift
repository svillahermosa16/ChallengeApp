//
//  MockSearchRepository.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 03/06/2025.
//


import Foundation
@testable import ChallengeApp

class MockSearchRepository: SearchRepositoryProtocol {
    
    private var shouldThrow = false
    private var error = APIError.unknown
    private var shouldDelay = false
    private var delayDuration: UInt64 = 100_000_000
    
    var searchProductDetailsCallCount = 0
    var lastSearchedProductId: String?
    var searchProductsCallCount = 0
    var lastSearchQuery: String?
    
    func configureSuccess() {
        shouldThrow = false
        shouldDelay = false
    }
    
    func configureSuccessWithDelay(duration: UInt64 = 100_000_000) {
        shouldThrow = false
        shouldDelay = true
        delayDuration = duration
    }
    
    func configureError(_ error: APIError = .unknown) {
        shouldThrow = true
        self.error = error
        shouldDelay = false
    }
    
    func configureErrorWithDelay(_ error: APIError = .unknown, duration: UInt64 = 100_000_000) {
        shouldThrow = true
        self.error = error
        shouldDelay = true
        delayDuration = duration
    }
    
    func reset() {
        shouldThrow = false
        error = APIError.unknown
        shouldDelay = false
        delayDuration = 100_000_000
        searchProductDetailsCallCount = 0
        lastSearchedProductId = nil
        searchProductsCallCount = 0
        lastSearchQuery = nil
    }
    
    func searchProductDetails(productId: String) async throws -> ProductDetail {
        searchProductDetailsCallCount += 1
        lastSearchedProductId = productId
        
        if shouldDelay {
            try await Task.sleep(nanoseconds: delayDuration)
        }
        
        if shouldThrow {
            throw error
        }
        
        return ProductDetail.mockValue()
    }
    
    func searchProduct(query: String) async throws -> ProductSearchResponse {
        searchProductsCallCount += 1
        lastSearchQuery = query
        
        if shouldDelay {
            try await Task.sleep(nanoseconds: delayDuration)
        }
        
        if shouldThrow {
            throw error
        }
        
        return ProductSearchResponse.mockValue()
    }
}
