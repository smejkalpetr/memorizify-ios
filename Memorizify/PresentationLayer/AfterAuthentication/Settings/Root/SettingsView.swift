//
//  SettingsView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Text("Settings View")
                    .padding()
                Button("Logout") {
                    router.logOut()
                }
            }
            .navigationDestination(for: SettingsRoute.self) { route in
                switch route {
                case .testPush:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
