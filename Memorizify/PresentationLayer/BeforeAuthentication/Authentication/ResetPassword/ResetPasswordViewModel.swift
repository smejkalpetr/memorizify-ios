//
//  ResetPasswordViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import SwiftUI
import Resolver

final class ResetPasswordViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var validateEmailUseCase: ValidateEmailUseCase
    @Injected private var resetPasswordUseCase: ResetPasswordUseCase
    
    struct State {
        var alert: AlertData? = nil
        var isResetPasswordButtonLoading = false
        
        var email = ""
        var emailError = ""

        var canResetPassword: Bool {
            emailError == "" &&
            !email.isEmpty
        }
    }
    
    @MainActor
    func resetPassword(completion: @escaping () -> ()) {
        Task {
            state.isResetPasswordButtonLoading = true
            defer { state.isResetPasswordButtonLoading = false }
            
            do {
                try await resetPasswordUseCase.execute(email: state.email)
                completion()
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Password Reset Failed",
                    message: "An error occured when reseting password. Please try again."
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
        } catch {}
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
