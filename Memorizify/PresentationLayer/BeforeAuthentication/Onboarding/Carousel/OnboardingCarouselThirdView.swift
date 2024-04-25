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
        VStack(alignment: .center) {
            Spacer()
            VStack {
                brainImage
                pageText
                continueButton
            }
            Spacer()
        }
    }
    
    private var brainImage: some View {
        Image("brain_logo_holding_hands_downscaled")
            .resizable()
            .scaledToFit()
            .padding()
    }
    
    private var pageText: some View {
        Text("Form a guild with your friends and embark on a collaborative studying journey together. Compare progress, engage in friendly competition, and most importantly, enjoy the process of learning as a team!")
            .font(.title3)
            .bold()
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var continueButton: some View {
        VStack {
            Button() {
                router.saveHasUserSeenOnboarding()
            } label: {
                Text("Continue to Sign Up")
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    OnboardingCarouselThirdView()
}
