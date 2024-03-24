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
        NavigationStack(path: $router.path) {
            VStack {
                Text("Board View")
            }
            .navigationDestination(for: BoardRoute.self) { route in
                switch route {
                case .testPush:
                    EmptyView()
                }
            }
            
        }
    }
}

#Preview {
    BoardView()
}
