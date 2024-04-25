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
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if RootState.isAppShowing {
                    AppView()
                } else {
                    EmptyView()
                }
            }
        }
    }
}
