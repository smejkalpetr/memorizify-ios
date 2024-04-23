//
//  AnimatePlaceholders.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.04.2024.
//

// This modifier is taken from the following publicly available source:
// https://dev.to/shohe/swiftui-animate-placeholder-modifier-for-view-5d06

import SwiftUI

struct AnimatePlaceholderModifier: AnimatableModifier {
    
    @Binding var isLoading: Bool

    @State private var isAnimated: Bool = false
    private var center = (UIScreen.main.bounds.width / 2) + 110
    private let animation: Animation = .linear(duration: 1.5)

    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    func body(content: Content) -> some View {
        content.overlay(animView.mask(content))
    }

    var animView: some View {
        ZStack {
            Color.black.opacity(isLoading ? 0.09 : 0.0)
            Color.white.mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors: [.clear, .white.opacity(0.48), .clear]), startPoint: .top , endPoint: .bottom)
                    )
                    .scaleEffect(1.5)
                    .rotationEffect(.init(degrees: 70.0))
                    .offset(x: isAnimated ? center : -center)
            )
        }
        .animation(isLoading ? animation.repeatForever(autoreverses: false) : nil, value: isAnimated)
        .onAppear {
            guard isLoading else { return }
            isAnimated.toggle()
        }
        .onChange(of: isLoading) { _ in
            isAnimated.toggle()
        }
    }
}

extension View {
    func animatePlaceholder(isLoading: Binding<Bool>) -> some View {
        self.modifier(AnimatePlaceholderModifier(isLoading: isLoading))
    }
}
