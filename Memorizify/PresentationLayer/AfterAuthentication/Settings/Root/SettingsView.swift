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
                ScrollView {
                    Text("Settings View")
                        .padding()
                    Button("Logout") {
                        router.logOut()
                    }
                    Button("Test notification") {
                        viewModel.scheduleNotification()
                    }
                    Spacer()
                    if let user = viewModel.state.user {
                        VStack {
                            Text(user.name)
                                .padding()
                            Text(user.email)
                                .padding()
                            Text(user.nickname ?? "No nickname")
                                .padding()
                            Text("\(user.score)")
                                .padding()
                            Text("\(user.guildIds)")
                                .padding()
                        }
                    }
                }
            }
            .task { await viewModel.getUserInfo() }
            .navigationDestination(for: SettingsRoute.self) { route in
                switch route {
                case .testPush:
                    EmptyView()
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .alert(item: Binding<AlertData?>(
                get: { viewModel.state.alert },
                set: { _ in viewModel.dismissAlert() }
            )) { alert in .init(alert) }
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
