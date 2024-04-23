//
//  OnboardingCarouselFirstView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct OnboardingCarouselFirstView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack {
                brainImage
                pageText
                paddingButton
            }
            Spacer()
        }
    }
    
    private var brainImage: some View {
        Image("brain_logo_with_m_downscaled")
            .resizable()
            .scaledToFit()
            .scaleEffect(0.8)
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
    
    private var paddingButton: some View {
        VStack {
            Button("") {}
        }
        .padding()
    }
}

#Preview {
    OnboardingCarouselFirstView()
}
