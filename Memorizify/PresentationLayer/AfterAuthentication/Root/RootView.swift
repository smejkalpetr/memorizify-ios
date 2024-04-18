//
//  RootView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var router: Router
    
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var storylinesViewModel = StorylinesViewModel()
    @StateObject var guildsViewModel = GuildsViewModel()
    @StateObject var boardViewModel = BoardViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        TabView(selection: $router.tab) {
            
            HomeView(viewModel: homeViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(Tab.home)
                .environmentObject(router)
            
            StorylinesView(viewModel: storylinesViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "scroll.fill")
                        Text("Storylines")
                    }
                }
                .tag(Tab.storylines)
                .environmentObject(router)
            
            
            GuildsView(viewModel: guildsViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("Guilds")
                    }
                }
                .tag(Tab.guilds)
                .environmentObject(router)
            
            
            BoardView(viewModel: boardViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "crown.fill")
                        Text("Board")
                    }
                }
                .tag(Tab.board)
                .environmentObject(router)
            
            SettingsView(viewModel: settingsViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .tag(Tab.settings)
                .environmentObject(router)
        }
    }
}

#Preview {
    RootView()
}
