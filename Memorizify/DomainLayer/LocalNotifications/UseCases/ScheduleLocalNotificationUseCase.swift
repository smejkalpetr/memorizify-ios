//
//  ScheduleLocalNotificationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import UserNotifications

/// Manages the scheduling of local notifications.
protocol ScheduleLocalNotificationUseCase {
    
    /// Executes the scheduling of a local notification.
    /// - Parameters:
    ///   - notification: The notification to be scheduled.
    ///   - timeInterval: The time interval after which the notification should be delivered.
    /// - Returns: The scheduled local notification.
    func execute(_ notification: LocalNotification, timeInterval: Double) -> LocalNotification
}

/// Implementation of the ScheduleLocalNotificationUseCase protocol.
struct ScheduleLocalNotificationUseCaseImpl: ScheduleLocalNotificationUseCase {
    
    /// Initializes the ScheduleLocalNotificationUseCaseImpl instance.
    init() {}
    
    /// Executes the scheduling of a local notification.
    /// - Parameters:
    ///   - notification: The notification to be scheduled.
    ///   - timeInterval: The time interval after which the notification should be delivered.
    /// - Returns: The scheduled local notification.
    func execute(_ notification: LocalNotification, timeInterval: Double) -> LocalNotification {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.message

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                NSLog("Error scheduling notification \(notification), failed with error: \(error.localizedDescription)")
            } else {
                NSLog("Notification: \(notification) scheduled successfully")
            }
        }
        
        return LocalNotification(copy: notification, identifier: identifier)
    }
}
