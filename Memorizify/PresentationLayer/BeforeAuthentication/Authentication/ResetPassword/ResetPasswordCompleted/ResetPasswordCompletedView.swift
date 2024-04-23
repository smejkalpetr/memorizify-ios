//
//  ResetPasswordCompletedView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct ResetPasswordCompletedView: View {
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                infoText
                backButton
            }
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 10
                )
                .fill(colorScheme == .dark ? .black : .white)
                .shadow(radius: 5, x: 3.5, y: 3.5)
            )
            .padding()
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
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var infoText: some View {
        Text("If there is an account associated with the provided email, a link will be sent to the email which will contain instruction on how to reset the password.")
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var backButton: some View {
        Button("Back") {
            router.clearAllPaths()
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

#Preview {
    ResetPasswordCompletedView()
}
