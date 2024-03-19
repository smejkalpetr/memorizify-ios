//
//  SecondaryButtonStyle.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    
    let isLoading: Bool
    
    init(isLoading: Bool = false) {
        self.isLoading = isLoading
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                configuration.label
                    .font(.callout)
                    .foregroundColor(.cyan)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.yellow, lineWidth: 3)
            }
        )
        .cornerRadius(5)
    }
}

#Preview {
    VStack {
        Button("Some Label") {}
            .buttonStyle(SecondaryButtonStyle())
            .padding()
        
        Button("Some Other Label") {}
            .buttonStyle(SecondaryButtonStyle(isLoading: true))
            .padding()
    }
}
