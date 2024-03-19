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
        var email = ""
        var emailError = ""

        var isResetPasswordButtonLoading = false
        
        var alert: AlertData? = nil
        
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
                state.alert = AlertData(
                    title: "Error",
                    message: "Something went wrong: \(error.localizedDescription)",
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
        } catch {}
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
