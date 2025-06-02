//
//  ErrorView.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//

import SwiftUI

struct ErrorView: View {
    let error: APIError?
    let actionBtnMessage: String
    let action: () -> Void
    var body: some View {
        if let error {
            Text(error.description)
        } else {
            Text(APIError.unknown.description)
        }
        
        Button(action:{
            action()
        }) {
            Text(actionBtnMessage)
                .foregroundStyle(.white)
                .font(Font.system(size: 16, weight: .bold))
                .clipShape(Capsule())
                .background {
                    Capsule()
                        .frame(width: 150, height: 40)
                }
        }
    }
}

#Preview {
    ErrorView(error: APIError.unknown, actionBtnMessage: "Reintentar", action: {})
}
