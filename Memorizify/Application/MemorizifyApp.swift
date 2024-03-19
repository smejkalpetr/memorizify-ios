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
            NavigationStack(path: $router.path) {
                if router.isLoggedIn {
                    ContentView()
                        .environmentObject(router)
                } else {
                    MainAuthenticationView()
                        .environmentObject(router)
                }
            }
            .onAppear { router.checkIsUserLoggedIn() }
        }
    }
}
