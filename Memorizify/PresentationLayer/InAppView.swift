//
//  InAppView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI

struct InAppView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Button("Push screen") {
                router.path.append(InAppRoutes.pushScreen("This is some text"))
            }
            .padding()
        }
        .navigationDestination(for: InAppRoutes.self) { route in
            switch route {
            case let .pushScreen(someString):
                PushedScreenView(someString: someString)
            }
        }
    }
}

#Preview {
    InAppView()
}
