//
//  LogInView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: LogInViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                headline
                logInForm
                resetPasswordLine
            }
            Spacer()
            logInButton
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
    }
            
    var headline: some View {
        Text("LOG IN")
            .font(.title)
            .bold()
            .padding()
    }
    
    var logInForm: some View {
        VStack {
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
        }
        .padding()
    }
    
    var resetPasswordLine: some View {
        HStack {
            Text("Forgot password?")
            Button("Reset it now!") {
                router.path.append(AuthenticationRoute.resetPassword)
            }
        }
    }
    
    var logInButton: some View {
        VStack {
            Button("Log In") {
                viewModel.logIn() { router.logIn() }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isLogInButtonLoading))
            .opacity(viewModel.state.canLogIn ? 1.0 : 0.3)
            .disabled(!viewModel.state.canLogIn)
        }
        .padding()
    }
}

#Preview {
    LogInView(viewModel: LogInViewModel())
}
