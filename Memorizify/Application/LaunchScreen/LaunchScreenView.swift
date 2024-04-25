//
//  LaunchScreenView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.04.2024.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color("secondary_color")
                .ignoresSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.5)
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
