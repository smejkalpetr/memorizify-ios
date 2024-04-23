//
//  RootAuthenticationView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI

struct RootAuthenticationView: View {
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack(path: $router.authenticationPath) {
            VStack {
                Spacer()
                headline
                brainImage
                Spacer()
                signUpLoginButtons
            }
            .background {
                backgroundImage
            }
            .navigationDestination(for: AuthenticationRoute.self) { route in
                switch route {
                case .signUp:
                    let vm = SignUpViewModel()
                    SignUpView(viewModel: vm)
                        .environmentObject(router)
                case .signUpCompleted:
                    SignUpCompletedView()
                        .environmentObject(router)
                case .logIn:
                    let vm = LogInViewModel()
                    LogInView(viewModel: vm)
                        .environmentObject(router)
                case .resetPassword:
                    let vm = ResetPasswordViewModel()
                    ResetPasswordView(viewModel: vm)
                        .environmentObject(router)
                case .resetPasswordCompleted:
                    ResetPasswordCompletedView()
                        .environmentObject(router)
                }
            }
        }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_authentication")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.35)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    var headline: some View {
        Text("Welcome to Memorizify")
            .font(.title)
            .bold()
            .padding()
            .shadow(radius: 1)
    }
    
    private var brainImage: some View {
        Image("brain_logo_with_m_downscaled")
            .resizable()
            .scaledToFit()
            .scaleEffect(0.9)
            .padding()
    }
    
    var signUpLoginButtons: some View {
        VStack {
            Button("Sign Up") {
                router.authenticationPath.append(AuthenticationRoute.signUp)
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button("Log In") {
                router.authenticationPath.append(AuthenticationRoute.logIn)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
}

#Preview {
    RootAuthenticationView()
}
