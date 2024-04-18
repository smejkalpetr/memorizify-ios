//
//  SettingsViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI
import Resolver

final class SettingsViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var scheduleLocalNotificationUseCase: ScheduleLocalNotificationUseCase
    @Injected private var getCurrentUserUseCase: GetCurrentUserUseCase
    
    struct State {
        var alert: AlertData?
        var user: User?
    }
    
    func scheduleNotification() {
        let _ = scheduleLocalNotificationUseCase.execute(LocalNotification(title: "Test", message: "This is a test notification!"), timeInterval: 4.0)
    }
    
    @MainActor
    func getUserInfo() async {
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
    func dismissAlert() {
        state.alert = nil
    }
}
