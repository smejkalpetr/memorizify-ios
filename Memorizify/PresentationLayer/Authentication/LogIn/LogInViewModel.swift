//
//  LogInViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI
import Resolver

final class LogInViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var logInUseCase: LogInUseCase
    @Injected private var sendEmailVerificationUseCase: SendEmailVerificationUseCase
    @Injected private var validateEmailUseCase: ValidateEmailUseCase
    
    struct State {
        var email = ""
        var password = ""
        
        var emailError = ""

        var isLogInButtonLoading = false
        
        var alert: AlertData? = nil
        
        var canLogIn: Bool {
            emailError == "" &&
            [email, password].allSatisfy { !$0.isEmpty }
        }
    }
    
    @MainActor
    func logIn(completion: @escaping () -> ()) {
        guard state.canLogIn else { return }
        
        Task {
            state.isLogInButtonLoading = true
            defer { state.isLogInButtonLoading = false }
            
            clearAllErrors()
            
            do {
                try await logInUseCase.execute(
                    data:
                        LogInData(
                            email: state.email,
                            password: state.password
                        )
                )
                completion()
            } catch FirebaseUserError.emailNotVerified {
                state.alert = AlertData(
                    title: "Email not verified",
                    message: "Your email is not verified. Do you wish to resend the email verification link to your email?",
                    primaryAction: AlertData.Action(
                        title: "Send",
                        style: .cancel,
                        handler: sendEmailVerification
                    ),
                    secondaryAction: AlertData.Action(
                        title: "Cancel",
                        style: .default
                    )
                )
            } catch {
                state.alert = AlertData(
                    title: "Error",
                    message: error.localizedDescription,
                    primaryAction: AlertData.Action(
                        title: "Cancel",
                        style: .cancel
                    )
                )
            }
        }
    }
    
    @MainActor
    func validateEmailField() {
        state.emailError = ""
        
        do {
            try validateEmailUseCase.execute(email: state.email)
        } catch ValidationError.invalidEmail {
            state.emailError = "Wrong email format"
        } catch {
            state.alert = AlertData(
                title: "Error",
                message: error.localizedDescription,
                primaryAction: AlertData.Action(
                    title: "Cancel",
                    style: .cancel
                )
            )
        }
    }
    
    @MainActor
    func sendEmailVerification() {
        Task {
            state.isLogInButtonLoading = true
            defer { state.isLogInButtonLoading = false }
            
            do {
                try await sendEmailVerificationUseCase.execute()
            } catch {
                state.alert = AlertData(
                    title: "Error",
                    message: "An error occured when seding verification email: \(error.localizedDescription)",
                    primaryAction: AlertData.Action(
                        title: "Cancel",
                        style: .cancel
                    )
                )
            }
            
            state.alert = AlertData(
                title: "Verification sent",
                message: "To verify your account, please click on the verification link in your email. Then, you'll be able to log in.",
                primaryAction: AlertData.Action(
                    title: "Cancel",
                    style: .cancel
                )
            )
        }
    }
    
    @MainActor
    func clearAllErrors() {
        state.emailError = ""
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
