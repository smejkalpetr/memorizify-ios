//
//  BoardView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct BoardView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.boardPath) {
            VStack {
                Text("Board View")
            }
            .navigationDestination(for: BoardRoute.self) { route in
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
    BoardView()
}
