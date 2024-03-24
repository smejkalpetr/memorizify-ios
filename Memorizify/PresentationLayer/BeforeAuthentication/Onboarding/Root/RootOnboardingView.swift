//
//  RootOnboardingView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct RootOnboardingView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            TabView {
                OnboardingCarouselFirstView()
                    .tabItem { Text("first") }
                
                OnboardingCarouselSecondView()
                    .tabItem { Text("second") }
                
                OnboardingCarouselThirdView()
                    .environmentObject(router)
                    .tabItem { Text("third") }
            }
            .background(Color.yellow)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    RootOnboardingView()
}
