//
//  RootOnboardingView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct RootOnboardingView: View {
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selection = 0
    
    var body: some View {
        VStack {
            onboardingTabView
            PageControlView(numberOfPages: 3, currentPage: $selection)
                .padding(.bottom, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? .black : .white)
                .shadow(radius: 5, x: 3.5, y: 3.5)
        )
        .padding()
        .background {
            backgroundImage
        }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_authentication")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var onboardingTabView: some View {
        TabView(selection: $selection) {
            OnboardingCarouselFirstView()
                .tabItem { Text("first") }
                .tag(0)
            
            OnboardingCarouselSecondView()
                .tabItem { Text("second") }
                .tag(1)
            
            OnboardingCarouselThirdView()
                .environmentObject(router)
                .tabItem { Text("third") }
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}



#Preview {
    RootOnboardingView()
}
