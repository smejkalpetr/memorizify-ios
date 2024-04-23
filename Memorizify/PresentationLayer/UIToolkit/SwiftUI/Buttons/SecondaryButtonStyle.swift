//
//  SecondaryButtonStyle.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    
    @Environment(\.colorScheme) var colorScheme
    
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
        .background(Color("secondary_color").opacity(colorScheme == .dark ? 0 : 1))
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    colorScheme == .dark ? Color("secondary_color") : Color("primary_color"),
                    lineWidth: 3
                )
        )
        .shadow(radius: 2.5, x: 1.5, y: 1.5)
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
