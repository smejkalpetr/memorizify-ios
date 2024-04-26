//
//  SignUpViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI
import Resolver
import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var signUpUseCase: SignUpUseCase
    @Injected private var validateUsernameUseCase: ValidateUsernameUseCase
    @Injected private var validateEmailUseCase: ValidateEmailUseCase
    @Injected private var validatePasswordUseCase: ValidatePasswordUseCase
    @Injected private var validateRepeatedPasswordUseCase: ValidateRepeatedPasswordUseCase
    
    struct State {
        var alert: AlertData?
        
        var username = ""
        var email = ""
        var password = ""
        var repeatedPassword = ""
        
        var usernameError: LocalizedStringResource = ""
        var emailError: LocalizedStringResource = ""
        var passwordError: LocalizedStringResource = ""
        var repeatedPasswordError: LocalizedStringResource = ""
        var agreementError: LocalizedStringResource = ""
        
        var isAgreementSigned = false
        var isSignUpButtonLoading = false
        
        var canSignUp: Bool {
            [usernameError, emailError, passwordError, repeatedPasswordError].allSatisfy { $0 == "" } &&
            [username, email, password, repeatedPassword].allSatisfy { !$0.isEmpty } &&
            isAgreementSigned
        }
    }
    
    @MainActor
    func signUp(completion: @escaping () -> ()) {
        guard state.canSignUp else { return }
        
        Task {
            defer { state.isSignUpButtonLoading = false }
            state.isSignUpButtonLoading = true
            
            clearAllErrors()
            
            do {
                try await signUpUseCase.execute(
                    data: SignUpData(
                        username: state.username,
                        email: state.email,
                        password: state.password,
                        repeatedPassword: state.repeatedPassword
                    )
                )
                completion()
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Sign Up Failed",
                    message: "An error occured during sign up. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func validateNameField() {
        state.usernameError = ""
        
        do {
            try validateUsernameUseCase.execute(username: state.username)
        } catch ValidationError.invalidUsername {
            state.usernameError = "Username must be 2-32 characters long"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
            )
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
    func validatePasswordField() {
        state.passwordError = ""
        
        do {
            try validatePasswordUseCase.execute(password: state.password)
        } catch ValidationError.invalidPassword {
            state.passwordError = "Password must be at least 8 characters long, contain at least one digit and at least one upper case character"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
            )
        }
    }
    
    @MainActor
    func validateRepeatedPasswordField() {
        state.repeatedPasswordError = ""
        
        do {
            try validateRepeatedPasswordUseCase.execute(password: state.password, repeatedPassword: state.repeatedPassword)
        } catch ValidationError.invalidRepeatedPassword {
            state.repeatedPasswordError = "Password are not the same"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
            )
        }
    }
    
    @MainActor
    func validateAgreementSignature() {
        guard state.isAgreementSigned else {
            state.agreementError = "You have to agree to the terms and conditions"
            return
        }
    }
    
    @MainActor
    func clearAllErrors() {
        state.usernameError = ""
        state.emailError = ""
        state.passwordError = ""
        state.repeatedPasswordError = ""
        state.agreementError = ""
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
