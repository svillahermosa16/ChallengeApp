//
//  NetworkServiceTests.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//

import XCTest
@testable import ChallengeApp
import Network

class NetworkServiceTests: XCTestCase {
    
    let service = NetworkService.init()

    func testNetworkComponents() {
        
        var isConnected = true
        let networkMonitor = NWPathMonitor()
        let workerQueue = DispatchQueue(label: "networkMonitor")
        networkMonitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
        
        XCTAssertNotNil(service.session)
        XCTAssertEqual(service.isConnected, isConnected)
        
    }
    
    func testAddHeaders() {
        var urlRequest = URLRequest(url: URL(string: "https://www.google.com")!)
        let apiRequest = APIRequest(path: .product, method: .get, parameters: [:], headers: .baseAuthInit())
        
        service.addHeaders(request: &urlRequest, apiRequest: apiRequest)
        
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), Constants.authToken)
    }
    
    func testNoInternetThrow() async {
            
            service.isConnected = false
        
            let apiRequest = APIRequest(path: .product, method: .get, parameters: [:], headers: .baseAuthInit())
            
            do {
                _ = try await service.request(apiRequest: apiRequest, responseType: ProductResponse.self)
                XCTFail("Should throw APIError.noInternetConnection")
            } catch APIError.noInternetConnection {
                XCTAssert(true, "Correct error type")
            } catch {
                XCTFail("Wrong error type: \(error)")
            }
        }
        
        func testBadURL() async {
            let badAPIRequest = BadURLAPIRequest()
            
            do {
                _ = try await service.request(apiRequest: badAPIRequest, responseType: ProductResponse.self)
                XCTFail("Should throw badURL")
            } catch APIError.badURL {
                XCTAssert(true, "Threw badURL")
            } catch {
                XCTFail("Wrong error type: \(error)")
            }
        }
        
        func testMethodSetup() {
            
            let getRequest = APIRequest(path: .product, method: .get, parameters: [:], headers: .baseAuthInit())
            let postRequest = APIRequest(path: .product, method: .post, parameters: ["key": "value"], headers: .baseAuthInit())
            
            var urlRequest = URLRequest(url: getRequest.url!)
            
            urlRequest.httpMethod = getRequest.method.rawValue
            
            XCTAssertEqual(urlRequest.httpMethod, "GET")
            XCTAssertNil(urlRequest.httpBody)
            
            urlRequest.httpMethod = postRequest.method.rawValue
            if postRequest.method == .post {
                urlRequest.httpBody = try? postRequest.parameters.encode()
            }
            
            XCTAssertEqual(urlRequest.httpMethod, "POST")
            XCTAssertNotNil(urlRequest.httpBody)
        }
        
        func testParametersEncodingForPOST() throws {
            
            let parameters: RequestParameters = .searchParametersInit(query: "test")
            let postRequest = APIRequest(path: .product, method: .post, parameters: parameters, headers: .baseAuthInit())
            
            let encodedData = try postRequest.parameters.encode()
            
            if let encodedData {
                XCTAssertNotNil(encodedData)
                XCTAssertGreaterThan(encodedData.count, 0)
                
                let decodedDict = try JSONSerialization.jsonObject(with: encodedData) as? [String: Any]
                XCTAssertNotNil(decodedDict)
                XCTAssertEqual(decodedDict?["q"] as? String, "test")
            } else {
                XCTFail("Could not encode parameters")
            }
        }
}




