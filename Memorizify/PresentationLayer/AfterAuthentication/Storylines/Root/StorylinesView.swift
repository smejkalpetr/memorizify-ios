//
//  StorylinesView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct StorylinesView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                ScrollView {
                    Button("push") {
                        router.path.append(StorylinesRoute.pushTest)
                    }
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                    Text("Storylines View")
                }
            }
            .navigationTitle("Storylines")
            .navigationDestination(for: StorylinesRoute.self) { route in
                switch route {
                case .pushTest:
                    Text("test view")
                }
            }
        }
    }
}

#Preview {
    StorylinesView()
}
