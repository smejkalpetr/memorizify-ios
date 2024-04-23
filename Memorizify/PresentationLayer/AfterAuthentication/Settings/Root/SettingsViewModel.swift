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
        var isUserLoading = false
        var alert: AlertData?
        var user: User?
    }
    
    // MARK: Public
    
    @MainActor
    func getUserInfo() async {
        defer { state.isUserLoading = false }
        state.isUserLoading = true
        
        do {
            state.user = try await getCurrentUserUseCase.execute()
        } catch {
            state.alert = AlertData(
                title: "Error fetching user",
                message: "An error occured when fetching user data."
            )
        }
    }
    
    @MainActor
    func getLanguageInfo() {
        
    }
    
    @MainActor
    func openLanguageSettings() {
        state.alert = AlertData(
            title: "Change language",
            message: "To change language, System Settings will open. Please select the desired laguage there.",
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
            title: "Change notifications settings",
            message: "To change notifications settings, System Settings will open. Please the settings there.",
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
        guard let identifier else { return LanguageSetting.unknown.rawValue }
        return getFullLanguageNameForIdentifierUseCase.execute(identifier: identifier).rawValue
    }
    
    // MARK: Private
    
    private func openLanguageSettingsAction() {
        do {
            try changeLanguageSettingsUseCase.execute()
        } catch {
            state.alert = AlertData(
                title: "Error openning System Settings",
                message: "An error occured when opening System Settings. Please try again."
            )
        }
    }
    
    private func openNotificationsSettingsAction() {
        do {
            try changeNotificationsSettingsUseCase.execute()
        } catch {
            state.alert = AlertData(
                title: "Error openning System Settings",
                message: "An error occured when opening System Settings. Please try again."
            )
        }
    }
}
