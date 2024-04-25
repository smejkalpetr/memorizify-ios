//
//  LogInViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI
import Resolver
import Foundation

final class LogInViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var logInUseCase: LogInUseCase
    @Injected private var sendEmailVerificationUseCase: SendEmailVerificationUseCase
    @Injected private var validateEmailUseCase: ValidateEmailUseCase
    
    struct State {
        var alert: AlertData? = nil
        var isLogInButtonLoading = false
        
        var email = ""
        var password = ""
        
        var emailError: LocalizedStringResource = ""
        
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
                    title: "Email Not Verified",
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
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Unknown Error",
                    message: "An unknown error has occured."
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
            state.emailError = "Wrong Email Format"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
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
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Sending Email Verification Failed",
                    message: "An error occured when seding verification email. Please try again."
                )
            }
            
            state.alert = AlertData(
                title: "Verification Sent",
                message: "To verify your account, please click on the verification link in your email. Then, you'll be able to log in."
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
