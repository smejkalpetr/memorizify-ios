//
//  OnboardingCarouselThirdView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct OnboardingCarouselThirdView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("third")
            Button("Continue to Log in") {
                router.saveHasUserSeenOnboarding()
            }
        }
    }
}

#Preview {
    OnboardingCarouselThirdView()
}
