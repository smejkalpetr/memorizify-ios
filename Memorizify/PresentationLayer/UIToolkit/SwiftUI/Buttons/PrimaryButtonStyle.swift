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
                    .bold()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("primary_color"))
        .cornerRadius(5)
        .shadow(radius: 5, x: 2.5, y: 2.5)
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
