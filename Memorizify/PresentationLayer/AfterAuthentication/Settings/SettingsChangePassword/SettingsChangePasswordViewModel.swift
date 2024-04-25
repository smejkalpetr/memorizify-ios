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
        var alert: AlertData?
        var isLoading = false
        
        var currentPassword = ""
        var newPassword = ""
        var repeatNewPassword = ""
        
        var newPasswordError: LocalizedStringResource = ""
        var repeatNewPasswordError: LocalizedStringResource = ""
        
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
                    title: "Password Changed",
                    message: "Your password has been changed.",
                    primaryAction: .init(
                        title: "Close",
                        handler: { completion() }
                    )
                )
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Changing Password Failed",
                    message: "An error occured when changing the password. Please try again."
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
            state.newPasswordError = "Password must be at least 8 characters long, contain at least one digit and at least one upper case character"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
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
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
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
