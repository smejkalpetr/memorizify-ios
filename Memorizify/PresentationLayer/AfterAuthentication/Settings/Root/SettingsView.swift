//
//  SettingsView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack(path: $router.settingsPath) {
            VStack {
                Text("Settings View")
                    .padding()
                Button("Logout") {
                    router.logOut()
                }
                Button("Test notification") {
                    viewModel.scheduleNotification()
                }
            }
            .navigationDestination(for: SettingsRoute.self) { route in
                switch route {
                case .testPush:
                    EmptyView()
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
