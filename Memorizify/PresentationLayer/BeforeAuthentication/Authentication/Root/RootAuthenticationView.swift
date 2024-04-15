//
//  RootAuthenticationView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI

struct RootAuthenticationView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.authenticationPath) {
            VStack {
                Spacer()
                headline
                Spacer()
                signUpLoginButtons
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
    
    var headline: some View {
        Text("Welcome to Memorizify!")
            .font(.title)
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
