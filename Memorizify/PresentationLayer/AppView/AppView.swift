//
//  AppView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 25.04.2024.
//

import SwiftUI

struct AppView: View {
    
    @StateObject var router = Router()
    
    var body: some View {
        VStack {
            if router.isLoggedIn {
                RootView()
                    .environmentObject(router)
            } else {
                if router.hasSeenOnboarding {
                    RootAuthenticationView()
                        .environmentObject(router)
                } else if router.isShowingOnboarding {
                    RootOnboardingView()
                        .environmentObject(router)
                } else {
                    LaunchScreenView()
                }
            }
        }
        .onAppear { router.initialize() }
    }
}

#Preview {
    AppView()
}
