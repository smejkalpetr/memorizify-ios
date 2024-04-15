//
//  SettingsViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI
import Resolver

final class SettingsViewModel: ObservableObject {
    
    @Injected private var scheduleLocalNotificationUseCase: ScheduleLocalNotificationUseCase
    
    func scheduleNotification() {
        let _ = scheduleLocalNotificationUseCase.execute(LocalNotification(title: "Test", message: "This is a test notification!"), timeInterval: 4.0)
    }
}
