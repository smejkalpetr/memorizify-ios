//
//  ContentView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI
import Resolver

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var model: SomeModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Logout") {
                router.logOut()
            }
            Button("Add") {
                model.keychainAdd()
            }
            Button("Remove") {
                model.keychainRemove()
            }
            Button("Read") {
                model.keychainRead()
            }
            Text(model.value)
        }
        .padding()
    }
}

final class SomeModel: ObservableObject {
    @Published var value = ""
    
    @Injected var keychainProvider: KeychainProvider
    
    func keychainAdd() {
        do {
            try keychainProvider.add(.testKey, value: "some value here")
        } catch {
            print("error: \(error)")
        }
    }
    
    func keychainRemove() {
        do {
            try keychainProvider.remove(.testKey)
        } catch {
            print("error: \(error)")
        }
    }
    
    func keychainRead() {
        do {
            value = try keychainProvider.read(.testKey)
        } catch {
            print("error: \(error)")
        }
    }
}

#Preview {
    ContentView(model: SomeModel())
}
