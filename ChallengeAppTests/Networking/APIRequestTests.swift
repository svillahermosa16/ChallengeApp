//
//  APIRequestTests.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//

import XCTest
@testable import ChallengeApp

class APIRequestTests: XCTestCase {
    
    func testSimpleURL() {
        
        let request = APIRequest(path: .product, method: .get, parameters: [:], headers: .baseAuthInit(), suffix: "MLA")
        let url = request.url
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "https://api.mercadolibre.com/products/MLA")
    }
    
    func testFullPathURL() {
        let request = APIRequest(path: .search, method: .get, parameters: .searchParametersInit(query: "Macbook"))
        
        let url = request.url
        
        XCTAssertNotNil(url)
        let urlString = url?.absoluteString ?? ""
        XCTAssertTrue(urlString.starts(with: "https://api.mercadolibre.com/"))
        XCTAssertTrue(urlString.contains("/search?"))
        XCTAssertTrue(urlString.contains("q=Macbook"))
        XCTAssertTrue(urlString.contains("limit=1000"))
    }

}
