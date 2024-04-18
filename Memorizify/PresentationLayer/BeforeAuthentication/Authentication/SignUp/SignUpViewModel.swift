//
//  SignUpViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import SwiftUI
import Resolver

final class SignUpViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var signUpUseCase: SignUpUseCase
    @Injected private var validateNameUseCase: ValidateNameUseCase
    @Injected private var validateNicknameUseCase: ValidateNicknameUseCase
    @Injected private var validateEmailUseCase: ValidateEmailUseCase
    @Injected private var validatePasswordUseCase: ValidatePasswordUseCase
    @Injected private var validateRepeatedPasswordUseCase: ValidateRepeatedPasswordUseCase
    
    struct State {
        var name = ""
        var nickname = ""
        var email = ""
        var password = ""
        var repeatedPassword = ""
        
        var nameError = ""
        var nicknameError = ""
        var emailError = ""
        var passwordError = ""
        var repeatedPasswordError = ""
        var signUpError = ""
        
        var isAgreementSigned = false
        var isSignUpButtonLoading = false
        
        var canSignUp: Bool {
            [nameError, emailError, passwordError, repeatedPasswordError].allSatisfy { $0 == "" } &&
            [name, email, password, repeatedPassword].allSatisfy { !$0.isEmpty } &&
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
                        name: state.name,
                        nickname: state.nickname,
                        email: state.email,
                        password: state.password,
                        repeatedPassword: state.repeatedPassword
                    )
                )
                completion()
            } catch {
                state.signUpError = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func validateNameField() {
        state.nameError = ""
        
        do {
            try validateNameUseCase.execute(name: state.name)
        } catch ValidationError.invalidName {
            state.nameError = "Name must be 2-32 characters long"
        } catch {
            state.signUpError = "Unknown error"
        }
    }
    
    @MainActor
    func validateNicknameField() {
        state.nameError = ""
        
        do {
            try validateNicknameUseCase.execute(nickname: state.nickname)
        } catch ValidationError.invalidNickname {
            state.nickname = "Nickname must be 2-32 characters long"
        } catch {
            state.signUpError = "Unknown error"
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
            state.signUpError = "Unknown error"
        }
    }
    
    @MainActor
    func validatePasswordField() {
        state.passwordError = ""
        
        do {
            try validatePasswordUseCase.execute(password: state.password)
        } catch ValidationError.invalidPassword {
            state.passwordError = "Password must be at least 8 characters long, contain at least one digit and at least one upper case letter"
        } catch {
            state.signUpError = "Unknown error"
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
            state.signUpError = "Unknown error"
        }
    }
    
    @MainActor
    func validateAgreementSignature() {
        guard state.isAgreementSigned else {
            state.signUpError = "You have to agree to the terms and conditions"
            return
        }
    }
    
    @MainActor
    func clearAllErrors() {
        state.nameError = ""
        state.emailError = ""
        state.passwordError = ""
        state.repeatedPasswordError = ""
        state.signUpError = ""
    }
}
