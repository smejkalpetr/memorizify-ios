//
//  HomeView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Text("Home View")
                Button("push in storylines") {
                    router.path.append(StorylinesRoute.pushTest)
                }
            }
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .testPush:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
