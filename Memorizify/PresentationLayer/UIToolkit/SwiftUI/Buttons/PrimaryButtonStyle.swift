//
//  PrimaryButtonStyle.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
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
        .background(.yellow)
        .cornerRadius(5)
    }
}

#Preview {
    VStack {
        Button("Some Label") {}
            .buttonStyle(PrimaryButtonStyle())
            .padding()
        
        Button("Some Other Label") {}
            .buttonStyle(PrimaryButtonStyle(isLoading: true))
            .padding()
    }
}
