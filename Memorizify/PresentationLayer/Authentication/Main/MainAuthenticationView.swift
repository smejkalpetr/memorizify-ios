//
//  MainAuthenticationView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI

struct MainAuthenticationView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Spacer()
            headline
            Spacer()
            SignUpLoginButtons
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
    
    var headline: some View {
        Text("Welcome to Memorizify!")
            .font(.title)
            .padding()
    }
    
    var SignUpLoginButtons: some View {
        VStack {
            Button("Sign Up") {
                router.path.append(AuthenticationRoute.signUp)
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button("Log In") {
                router.path.append(AuthenticationRoute.logIn)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
}

#Preview {
    MainAuthenticationView()
}
