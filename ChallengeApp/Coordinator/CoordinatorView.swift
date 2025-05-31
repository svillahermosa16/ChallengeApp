//
//  CoordinatorView.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var mainCoordinator: MainCoordinator = MainCoordinator()
    
    var body: some View {
        NavigationStack(path: $mainCoordinator.path) {
            mainCoordinator.buildContent(.home)
                .navigationDestination(for: Screen.self) { screen in
                    mainCoordinator.buildContent(screen)
                }
        }
        .environmentObject(mainCoordinator)
    }
}

#Preview {
    CoordinatorView()
}
