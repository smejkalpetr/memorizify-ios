//
//  CancelLocalNotificationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 25.04.2024.
//

import UserNotifications

/// Manages the cancellation of local notifications.
protocol CancelLocalNotificationUseCase {
    
    /// Executes the cancellation of a local notification.
    /// - Parameter identifier: The identifier of the notification to cancel.
    func execute(identifier: String)
}

/// Implementation of the CancelLocalNotificationUseCase protocol.
struct CancelLocalNotificationUseCaseImpl: CancelLocalNotificationUseCase {
    
    /// Initializes the CancelLocalNotificationUseCaseImpl instance.
    init() {}
    
    /// Executes the cancellation of a local notification.
    /// - Parameter identifier: The identifier of the notification to cancel.
    func execute(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
