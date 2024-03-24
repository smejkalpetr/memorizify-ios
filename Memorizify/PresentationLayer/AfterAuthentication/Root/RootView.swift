//
//  RootView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .environmentObject(router)
            
            StorylinesView()
                .tabItem {
                    VStack {
                        Image(systemName: "scroll.fill")
                        Text("Storylines")
                    }
                }
                .environmentObject(router)
            
            BoardView()
                .tabItem {
                    VStack {
                        Image(systemName: "crown.fill")
                        Text("Board")
                    }
                }
                .environmentObject(router)
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .environmentObject(router)
        }
        .navigationTitle("Storylines")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    RootView()
}
