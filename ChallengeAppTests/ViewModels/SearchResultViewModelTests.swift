//
//  SearchResultViewModelTests.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 03/06/2025.
//

import XCTest
@testable import ChallengeApp

class SearchResultViewModelTests: XCTestCase {
    
    var viewModel: SearchResultViewModel!
    var mockRepository: MockSearchRepository!
    var state: SearchResultState!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSearchRepository()
        state = .mock()
        viewModel = SearchResultViewModel(
            state: state,
            repository: mockRepository
        )
    }
    
    override func tearDown() {
        mockRepository.reset()
        state = .mock()
        viewModel = nil
        mockRepository = nil
        state = nil
        super.tearDown()
    }
    
    func testMockSearch() async {
        let intent = SearchResultIntent.search
        mockRepository.configureSuccessWithDelay(duration: 100_000_000)
        await viewModel.intentHandler(intent)
        
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertTrue(viewModel.state.searchCompleted)
        XCTAssertGreaterThan(viewModel.state.products.count, 0)
        XCTAssertNil(viewModel.state.error)
    }
    
    func testMockFailureSearch() async {
        let intent = SearchResultIntent.search
        mockRepository.configureError(APIError.unknown)
        await viewModel.intentHandler(intent)
        
        XCTAssertTrue(viewModel.state.products.isEmpty)
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertTrue(viewModel.state.searchCompleted)
        XCTAssertEqual(viewModel.state.error, APIError.unknown)
    }
}

