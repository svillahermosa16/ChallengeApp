//
//  PageControlView.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 01/06/2025.
//
import SwiftUI

struct PageControlView: View {
    let numberOfPages: Int
    @Binding var currentPage: Int
    
    var activeColor: Color = .blue
    var inactiveColor: Color = .gray
    var circleSize: CGFloat = 8
    var spacing: CGFloat = 8
    var activeCircleScale: CGFloat = 1.2
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? activeColor : inactiveColor.opacity(0.5))
                    .frame(width: circleSize * (index == currentPage ? activeCircleScale : 1.0),
                           height: circleSize * (index == currentPage ? activeCircleScale : 1.0))
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: currentPage)
            }
        }
    }
}
