//
//  SettingsChangePasswordViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

import SwiftUI
import Resolver

final class SettingsChangePasswordViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var state = State()
    
    @Injected private var changePasswordUseCase: ChangePasswordUseCase
    @Injected private var validatePasswordUseCase: ValidatePasswordUseCase
    @Injected private var validateRepeatedPasswordUseCase: ValidateRepeatedPasswordUseCase
    
    struct State {
        var isLoading = false
        var alert: AlertData?
        
        var currentPassword = ""
        var newPassword = ""
        var newPasswordError = ""
        var repeatNewPassword = ""
        var repeatNewPasswordError = ""
        
        var canChange: Bool {
            [newPasswordError, repeatNewPasswordError].allSatisfy { $0 == "" } &&
            [currentPassword, newPassword, repeatNewPassword].allSatisfy { !$0.isEmpty }
        }
    }
    
    // MARK: Public
    
    @MainActor
    func changePassword(completion: @escaping () -> ()) {
        guard state.canChange else { return }
        
        Task {
            defer { state.isLoading = false }
            state.isLoading = true
            
            clearAllErrors()
            
            do {
                try await changePasswordUseCase.execute(currentPassword: state.currentPassword, newPassword: state.newPassword)
                
                state.alert = AlertData(
                    title: "Password changed",
                    message: "Your password has been changed.",
                    primaryAction: .init(
                        title: "Close",
                        handler: { completion() }
                    )
                )
            } catch {
                state.alert = AlertData(
                    title: "Error changing password",
                    message: "An error occured when changing password. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func validateNewPasswordField() {
        state.newPasswordError = ""
        
        do {
            try validatePasswordUseCase.execute(password: state.newPassword)
        } catch ValidationError.invalidPassword {
            state.newPasswordError = "Password must be at least 8 characters long, contain at least one digit and at least one upper case letter"
        } catch {
            state.alert = AlertData(
                title: "Unknown error",
                message: "An unknown error occured. Please try again."
            )
        }
    }
    
    @MainActor
    func validateNewRepeatedPasswordField() {
        state.repeatNewPasswordError = ""
        
        do {
            try validateRepeatedPasswordUseCase.execute(
                password: state.newPassword,
                repeatedPassword: state.repeatNewPassword
            )
        } catch ValidationError.invalidRepeatedPassword {
            state.repeatNewPasswordError = "New passwords are not the same"
        } catch {
            state.alert = AlertData(
                title: "Unknown error",
                message: "An unknown error occured. Please try again."
            )
        }
    }
    
    @MainActor
    func clearAllErrors() {
        state.newPasswordError = ""
        state.repeatNewPasswordError = ""
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
