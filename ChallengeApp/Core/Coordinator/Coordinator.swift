//
//  Coordinator.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation
import SwiftUI

protocol Coordinator: ObservableObject {
    var path: NavigationPath { get set }
    func push(_ screen: Screen)
    func pop()
    func popToRoot()
}

class MainCoordinator: Coordinator {
    @Published var path: NavigationPath = NavigationPath()
    let repository: SearchRepository = SearchRepository()
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count - 1)
    }
    
    @ViewBuilder
    func buildContent(_ screen: Screen) -> some View {
        switch screen {
        case .home:
            HomeView()
        case .productList(let searchInput):
            SearchResultView(searchInput: searchInput, repository: repository)
        case .productDetail(let productId):
            let viewModel = ProductDetailViewModel(state: .init(productId: productId), repository: repository)
            ProductDetailView(viewModel: viewModel)
        }
    }
}


