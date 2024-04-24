//
//  SettingsViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI
import Resolver

final class SettingsViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var state = State()
    
    @Injected private var getCurrentUserUseCase: GetCurrentUserUseCase
    @Injected private var changeLanguageSettingsUseCase: ChangeLanguageSettingsUseCase
    @Injected private var changeNotificationsSettingsUseCase: ChangeNotificationsSettingsUseCase
    @Injected private var getFullLanguageNameForIdentifierUseCase: GetFullLanguageNameForIdentifierUseCase
    
    struct State {
        var alert: AlertData?
        var isUserLoading = false
        var user: User?
    }
    
    // MARK: Public
    
    @MainActor
    func getUserInfo() {
        Task {
            defer { state.isUserLoading = false }
            state.isUserLoading = true
            
            do {
                state.user = try await getCurrentUserUseCase.execute()
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Loading User Failed",
                    message: "An error occured when loading user data. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func openLanguageSettings() {
        state.alert = AlertData(
            title: "Change Language",
            message: "To change the language, System Settings will open. Please select your desired laguage there.",
            primaryAction: .init(
                title: "Continue",
                style: .cancel,
                handler: { self.openLanguageSettingsAction() }
            ),
            secondaryAction: .init(
                title: "Cancel"
            )
        )
    }
    
    @MainActor
    func openNotificationsSettings() {
        state.alert = AlertData(
            title: "Change Notification Preferences",
            message: "To change notifications settings, System Settings will open. Please select your notification preferences there.",
            primaryAction: .init(
                title: "Continue",
                style: .cancel,
                handler: { self.openNotificationsSettingsAction() }
            ),
            secondaryAction: .init(
                title: "Cancel"
            )
        )
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    func getLanguageName(identifier: String?) -> String {
        guard let identifier else { return String(localized: LanguageSetting.unknown.rawValue) }
        return String(localized: getFullLanguageNameForIdentifierUseCase.execute(identifier: identifier).rawValue)
    }
    
    // MARK: Private
    
    private func openLanguageSettingsAction() {
        do {
            try changeLanguageSettingsUseCase.execute()
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Opening System Settings Failed",
                message: "An error occured when opening the System Settings. Please try again."
            )
        }
    }
    
    private func openNotificationsSettingsAction() {
        do {
            try changeNotificationsSettingsUseCase.execute()
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Opening System Settings Failed",
                message: "An error occured when opening the System Settings. Please try again."
            )
        }
    }
}
