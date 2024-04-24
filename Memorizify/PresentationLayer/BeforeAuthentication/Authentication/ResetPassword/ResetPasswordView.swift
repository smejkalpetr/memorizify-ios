//
//  ResetPasswordView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @ObservedObject var viewModel: ResetPasswordViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                resetPasswordForm
            }
            Spacer()
            resetPasswordButton
        }
        .padding()
        .background {
            backgroundImage
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Reset Password")
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
    
    private var resetPasswordForm: some View {
        VStack {
            headline
            resetPasswordField
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
    
    private var headline: some View {
        VStack {
            Text("Please, fill in your email and we will attempt to send you a password reset link")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private var resetPasswordField: some View {
        VStack {
            TextField("", text: $viewModel.state.email)
                .textFieldStyle(PrimaryTextFieldStyle(title: "Email"))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onChange(of: viewModel.state.email) { viewModel.validateEmailField() }
            Text(viewModel.state.emailError)
                .foregroundStyle(.red)
                .font(.caption)
        }
        .padding()
    }
    
    private var resetPasswordButton: some View {
        VStack {
            Button("Reset Password") {
                viewModel.resetPassword() { router.authenticationPath.append(AuthenticationRoute.resetPasswordCompleted) }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isResetPasswordButtonLoading))
            .opacity(viewModel.state.canResetPassword ? 1.0 : 0.3)
            .disabled(!viewModel.state.canResetPassword)
        }
    }
}

#Preview {
    ResetPasswordView(viewModel: ResetPasswordViewModel())
}
