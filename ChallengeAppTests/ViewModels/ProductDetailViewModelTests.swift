//
//  ProductDetailViewModelTests.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 03/06/2025.
//

import XCTest
@testable import ChallengeApp

class ProductDetailViewModelTests: XCTestCase {
    
    var viewModel: ProductDetailViewModel!
    var mockRepository: MockSearchRepository!
    var state: ProductDetailState!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSearchRepository()
        state = .mock()
        viewModel = ProductDetailViewModel(
            state: state,
            repository: mockRepository
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        state = nil
        super.tearDown()
    }
    
    func testMockSearch() async {
        let intent = ProductDetailIntent.loadProduct
        mockRepository.configureSuccessWithDelay(duration: UInt64(0.1))
        await viewModel.intentHandler(intent)
        
        XCTAssertNotNil(viewModel.state.product)
        XCTAssertTrue(viewModel.state.isLoading == false)
        XCTAssertTrue(viewModel.state.product?.id ?? "" == "TEST")
    }
    
    func testMockFailureSearch() async {
        let intent = ProductDetailIntent.loadProduct
        mockRepository.configureError()
        await viewModel.intentHandler(intent)
        
        XCTAssertNil(viewModel.state.product)
        XCTAssertTrue(viewModel.state.isLoading == false)
        XCTAssertEqual(viewModel.state.error, APIError.unknown)
    }
}

