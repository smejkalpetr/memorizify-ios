//
//  LogInView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct LogInView: View {
    
    @ObservedObject var viewModel: LogInViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                logInForm
            }
            Spacer()
            logInButton
        }
        .padding()
        .background {
            backgroundImage
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Log In")
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
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
    
    private var logInForm: some View {
        VStack {
            emailField
            passwordField
            resetPasswordLine
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 5, x: 3.5, y: 3.5)
        )
    }
    
    @ViewBuilder
    private var emailField: some View {
        TextField("", text: $viewModel.state.email, onEditingChanged: { isStart in
            guard (!isStart) else { return }
            viewModel.validateEmailField()
        })
            .textFieldStyle(PrimaryTextFieldStyle(title: "Email"))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        Text(viewModel.state.emailError)
            .foregroundStyle(.red)
            .font(.caption)
    }
    
    private var passwordField: some View {
        SecureField("", text: $viewModel.state.password)
            .textFieldStyle(PrimaryTextFieldStyle(title: "Password"))
    }
    
    private var resetPasswordLine: some View {
        HStack {
            Text("Forgot password?")
            Button("Reset it now!") {
                router.authenticationPath.append(AuthenticationRoute.resetPassword)
            }
        }
        .padding()
    }
    
    private var logInButton: some View {
        VStack {
            Button("Log In") {
                viewModel.logIn() { router.logIn() }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isLogInButtonLoading))
            .opacity(viewModel.state.canLogIn ? 1.0 : 0.3)
            .disabled(!viewModel.state.canLogIn)
        }
    }
}

#Preview {
    LogInView(viewModel: LogInViewModel())
}
