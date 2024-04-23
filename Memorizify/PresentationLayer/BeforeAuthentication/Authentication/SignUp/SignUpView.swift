//
//  SignUpView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                signUpForm
            }
            Spacer()
            footer
        }
        .padding()
        .background {
            backgroundImage
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Sign Up")
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
    
    private var signUpForm: some View {
        VStack(alignment: .center) {
            usernameField
            emailField
            passwordField
            repeatPasswordField
            termsAndConditionsToggle
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
    private var usernameField: some View {
        TextField("", text: $viewModel.state.name, onEditingChanged: { isStart in
            guard (!isStart) else { return }
            viewModel.validateNameField()
        })
            .textFieldStyle(PrimaryTextFieldStyle(title: "Name"))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        Text(viewModel.state.nameError)
            .foregroundStyle(.red)
            .font(.caption)
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
    
    @ViewBuilder
    private var passwordField: some View {
        SecureField("", text: $viewModel.state.password)
            .textFieldStyle(PrimaryTextFieldStyle(title: "Password"))
            .onChange(of: viewModel.state.password) { viewModel.validatePasswordField() }
        Text(viewModel.state.passwordError)
            .foregroundStyle(.red)
            .font(.caption)
    }
    
    @ViewBuilder
    private var repeatPasswordField: some View {
        SecureField("", text: $viewModel.state.repeatedPassword)
            .textFieldStyle(PrimaryTextFieldStyle(title: "Repeat Password"))
            .onChange(of: viewModel.state.repeatedPassword) { viewModel.validateRepeatedPasswordField() }
        Text(viewModel.state.repeatedPasswordError)
            .foregroundStyle(.red)
            .font(.caption)
    }
    
    private var termsAndConditionsToggle: some View {
        Toggle("I agree to the terms and conditions", isOn: $viewModel.state.isAgreementSigned)
            .padding()
            .tint(Color("primary_color"))
    }
    
    private var footer: some View {
        VStack {
            Text(viewModel.state.signUpError)
                .foregroundStyle(.red)
            Button("Sign Up") {
                viewModel.signUp() { router.authenticationPath.append(AuthenticationRoute.signUpCompleted) }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isSignUpButtonLoading))
            .opacity(viewModel.state.canSignUp ? 1.0 : 0.3)
            .disabled(!viewModel.state.canSignUp)
        }
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel())
}
