//
//  ContentView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Logout") {
                router.logOut()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
