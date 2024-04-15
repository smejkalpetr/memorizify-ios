//
//  SignUpView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                headline
                signUpForm
            }
            Spacer()
            footer
        }
        .padding()
    }
    
    var headline: some View {
        Text("SIGN UP")
            .font(.title)
            .bold()
            .padding()
    }
    
    var signUpForm: some View {
        VStack(alignment: .center) {
            TextField("Name", text: $viewModel.state.name, onEditingChanged: { isStart in
                guard (!isStart) else { return }
                viewModel.validateNameField()
            })
            .textFieldStyle(PrimaryTextFieldStyle())
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            Text(viewModel.state.nameError)
                .foregroundStyle(.red)
            TextField("Email", text: $viewModel.state.email, onEditingChanged: { isStart in
                guard (!isStart) else { return }
                viewModel.validateEmailField()
            })
            .textFieldStyle(PrimaryTextFieldStyle())
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            Text(viewModel.state.emailError)
                .foregroundStyle(.red)
            SecureField("Password", text: $viewModel.state.password)
                .textFieldStyle(PrimaryTextFieldStyle())
                .onChange(of: viewModel.state.password) { viewModel.validatePasswordField() }
            Text(viewModel.state.passwordError)
                .foregroundStyle(.red)
            SecureField("Repeat Password", text: $viewModel.state.repeatedPassword)
                .textFieldStyle(PrimaryTextFieldStyle())
                .onChange(of: viewModel.state.repeatedPassword) { viewModel.validateRepeatedPasswordField() }
            Text(viewModel.state.repeatedPasswordError)
                .foregroundStyle(.red)
                .padding()
            Toggle("I agree to the terms and conditions", isOn: $viewModel.state.isAgreementSigned)
                .padding()
        }
        .padding()
    }
    
    var footer: some View {
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
