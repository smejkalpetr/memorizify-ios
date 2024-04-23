//
//  SettingsChangePasswordView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

import SwiftUI

struct SettingsChangePasswordView: View {
    
    @ObservedObject var viewModel: SettingsChangePasswordViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                changePasswordForm
            }
            Spacer()
            changePasswordButton
        }
        .padding()
        .background {
            backgroundImage
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Change Password")
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("background_settings")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var changePasswordForm: some View {
        VStack {
            currentPasswordField
            newPasswordField
            repeatNewPasswordField
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
    
    private var currentPasswordField: some View {
        SecureField("", text: $viewModel.state.currentPassword)
            .textFieldStyle(PrimaryTextFieldStyle(title: "Current Password"))
    }
    
    @ViewBuilder
    private var newPasswordField: some View {
        SecureField("", text: $viewModel.state.newPassword)
            .textFieldStyle(PrimaryTextFieldStyle(title: "New Password"))
            .onChange(of: viewModel.state.newPassword) { viewModel.validateNewPasswordField() }
        Text(viewModel.state.newPasswordError)
            .foregroundStyle(.red)
            .font(.caption)
    }
    
    @ViewBuilder
    private var repeatNewPasswordField: some View {
        SecureField("", text: $viewModel.state.repeatNewPassword)
            .textFieldStyle(PrimaryTextFieldStyle(title: "Repeat New Password"))
            .onChange(of: viewModel.state.repeatNewPassword) { viewModel.validateNewRepeatedPasswordField() }
        Text(viewModel.state.repeatNewPasswordError)
            .foregroundStyle(.red)
            .font(.caption)
    }
    
    private var changePasswordButton: some View {
        VStack {
            Button("Change password") {
                viewModel.changePassword() { presentationMode.wrappedValue.dismiss() }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isLoading))
            .opacity(viewModel.state.canChange ? 1.0 : 0.3)
            .disabled(!viewModel.state.canChange)
        }
    }
    
}

#Preview {
    SettingsChangePasswordView(viewModel: SettingsChangePasswordViewModel())
}
