//
//  SignUpCompletedView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct SignUpCompletedView: View {
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            completionBody
            Spacer()
        }
        .background {
            backgroundImage
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_authentication")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.4)
                    .ignoresSafeArea(.all)
            }
        }
    }
    
    private var completionBody: some View {
        VStack {
            VStack {
                successText
                infoText
            }
            .padding()
            backButton
        }
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 5, x: 3.5, y: 3.5)
        )
        .padding()
    }
    
    private var successText: some View {
        Text("Success!")
            .foregroundStyle(Color("primary_color"))
            .bold()
            .padding()
    }
    
    private var infoText: some View {
        Text("Please, check your inbox and verify the address using a link which was sent to your email!")
            .multilineTextAlignment(.center)
    }
    
    private var backButton: some View {
        Button("Back") {
            router.clearAllPaths()
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding()
    }
}

#Preview {
    SignUpCompletedView()
}
