//
//  View + Extension.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 01/06/2025.
//
import SwiftUI

public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

public struct FirstAppear: ViewModifier {
    let action: () -> ()
    @State private var hasAppeared = false
    
    public func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
