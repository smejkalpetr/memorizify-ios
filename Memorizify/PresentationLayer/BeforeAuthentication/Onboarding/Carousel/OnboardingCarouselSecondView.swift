//
//  OnboardingCarouselSecondView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct OnboardingCarouselSecondView: View {
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
        Image("brain_logo_waving_downscaled")
            .resizable()
            .scaledToFit()
            .scaleEffect(0.8)
            .padding()
    }
    
    private var pageText: some View {
        Text("Memorizify offers captivating storylines that immerse you in intriguing tales, enhancing your focus during Pomodoro Timer sessions. Explore these narratives to make your study sessions both productive and enjoyable.")
            .font(.title3)
            .bold()
            .multilineTextAlignment(.center)
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
    OnboardingCarouselSecondView()
}
