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
        Text("Welcome to Memorizify! Your all-in-one study companion. Track your progress, study with friends, and make learning an adventure. Start now and elevate your study game!")
            .font(.title3)
            .bold()
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
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
