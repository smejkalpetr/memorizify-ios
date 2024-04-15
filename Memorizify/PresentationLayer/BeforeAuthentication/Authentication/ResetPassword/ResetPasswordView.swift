//
//  ResetPasswordView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: ResetPasswordViewModel
    
    var body: some View {
        VStack {
            headline
            resetPasswordTextField
            Spacer()
            resetPasswordButton
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
    }
    
    var headline: some View {
        VStack {
            Text("RESET PASSWORD")
                .font(.title)
                .bold()
                .padding()
            Text("Fill in your email. We will send a password reset link to the given address.")
                .padding()
        }
    }
    
    var resetPasswordTextField: some View {
        VStack {
            TextField("Email", text: $viewModel.state.email)
                .textFieldStyle(PrimaryTextFieldStyle())
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onChange(of: viewModel.state.email) { viewModel.validateEmailField() }
            Text(viewModel.state.emailError)
                .foregroundStyle(.red)
        }
        .padding()
    }
    
    var resetPasswordButton: some View {
        VStack {
            Button("Reset password") {
                viewModel.resetPassword() { router.authenticationPath.append(AuthenticationRoute.resetPasswordCompleted) }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isResetPasswordButtonLoading))
            .opacity(viewModel.state.canResetPassword ? 1.0 : 0.3)
            .disabled(!viewModel.state.canResetPassword)
        }
        .padding()
    }
}

#Preview {
    ResetPasswordView(viewModel: ResetPasswordViewModel())
}
