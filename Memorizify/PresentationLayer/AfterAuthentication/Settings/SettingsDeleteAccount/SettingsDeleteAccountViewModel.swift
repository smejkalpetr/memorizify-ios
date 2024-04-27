//
//  SettingsDeleteAccountViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import SwiftUI
import Resolver

final class SettingsDeleteAccountViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var state = State()
    
    @Injected private var deleteAccountUseCase: DeleteAccountUseCase
    
    struct State {
        var alert: AlertData?
        var isLoading = false
        var password = ""
        
        var canDelete: Bool {
            return !password.isEmpty
        }
    }
    
    // MARK: Public
    
    @MainActor
    func deleteAccount() {
        state.alert = AlertData(
            title: "Delete Account",
            message: "Are you sure you want to delete your Memorizify account? This action cannot be taken back.",
            primaryAction: .init(
                title: "Cancel",
                style: .cancel
            ),
            secondaryAction: .init(
                title: "Continue",
                style: .destruction,
                handler: { self.funcDeleteAccountConfirmation() }
            )
        )
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    // MARK: Private
    
    @MainActor
    private func funcDeleteAccountConfirmation() {
        state.alert = AlertData(
            title: "Delete Account Confirmation",
            message: deleteInfoText(),
            primaryAction: .init(
                title: "Cancel",
                style: .cancel
            ),
            secondaryAction: .init(
                title: "Delete Account",
                style: .destruction,
                handler: { self.deleteAccountAction() }
            )
        )
    }
    
    @MainActor
    private func deleteInfoText() -> LocalizedStringResource {
        let messageText: LocalizedStringResource = """
            Are you absolutely sure you want to delete the account and all data associated with it? The following actions will be performed:
            
            \u{2022} Storylines deletion
            \u{2022} Invitations deletion
            \u{2022} Guilds deletion
            \u{2022} User data deletion
            \u{2022} User account deletion
            """

        return messageText
    }
    
    @MainActor
    private func deleteAccountAction() {
        Task {
            defer { state.isLoading = false }
            state.isLoading = true
            
            do {
                try await deleteAccountUseCase.execute(password: state.password)
                sendLogoutNotification()
            } catch AuthenticationError.wrongPassword {
                state.alert = AlertData(
                    title: "Wrong Password",
                    message: "You provided wrong password. Please try again."
                )
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Deleting Account Failed",
                    message: "An error occured when deleting account. Please try again."
                )
            }
        }
    }
    
    private func sendLogoutNotification() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
