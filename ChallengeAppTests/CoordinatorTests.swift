//
//  CoordinatorTests.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//

import XCTest
@testable import ChallengeApp

class CoordinatorTests: XCTestCase {
    
    var coordinator: MainCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = MainCoordinator()
    }
    
    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    func testRepository() {
        XCTAssertNotNil(coordinator.repository)
    }
    
    func testCoordinatorPush() {
        let homeScreen: Screen = .home
        coordinator.push(homeScreen)
        XCTAssertEqual(coordinator.path.count, 1)
        coordinator.pop()
    }
    
    func testCoordinatorPop() {
        let homeScreen: Screen = .home
        let listScreen: Screen = .productList("")
        coordinator.push(homeScreen)
        coordinator.push(listScreen)
        coordinator.pop()
        XCTAssertEqual(coordinator.path.count, 1)
    }
    
    func testCoordinatorPopToRoot() {
        let homeScreen: Screen = .home
        let listScreen: Screen = .productList("")
        let detailScreen: Screen = .productDetail("")
        coordinator.push(homeScreen)
        coordinator.push(listScreen)
        coordinator.push(detailScreen)
        coordinator.popToRoot()
        XCTAssertEqual(coordinator.path.count, 1)
    }
}
