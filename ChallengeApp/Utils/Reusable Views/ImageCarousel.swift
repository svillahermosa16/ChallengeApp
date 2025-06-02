//
//  ImageCarousel.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 01/06/2025.
//

import SwiftUI

struct ImageCarousel: View {
    var imageSource: [URL]
    @State private var currentPage: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                if imageSource.count > 0 {
                    Capsule()
                        .frame(width: 65, height: 30)
                        .foregroundStyle(.secondary)
                        .overlay {
                            Text("\(currentPage + 1) / \(imageSource.count)")
                                .font(Font.system(size: 14, weight: .medium))
                        }
                }
                
                TabView(selection: $currentPage) {
                    ForEach(imageSource.indices, id: \.self) { index in
                        VStack(alignment: .center) {
                            
                            AsyncImage(url: imageSource[index]) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: 300, height: 200)
                                default:
                                    ProgressView()
                                }
                            }
                            
                        }
                        .tag(index)
                    }
                }
                .frame(height: 300)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            
        }
        if imageSource.count > 1 {
            PageControlView(numberOfPages: imageSource.count, currentPage: $currentPage)
                .frame(height: 30)
        }
    }
}


