//
//  MemorizifyApp.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI

@main
struct MemorizifyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var router = Router()

    var body: some Scene {
        WindowGroup {
            VStack {
                if router.isLoggedIn {
                    RootView()
                        .environmentObject(router)
                } else {
                    if router.hasSeenOnboarding {
                        RootAuthenticationView()
                            .environmentObject(router)
                    } else {
                        RootOnboardingView()
                            .environmentObject(router)
                    }
                }
            }
            .onAppear { router.initialize() }
        }
    }
}
