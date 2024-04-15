//
//  ScheduleLocalNotificationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import UserNotifications

protocol ScheduleLocalNotificationUseCase {
    func execute(_ notification: LocalNotification, timeInterval: Double) -> LocalNotification
}

struct ScheduleLocalNotificationUseCaseImpl: ScheduleLocalNotificationUseCase {
    
    init() {}
    
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
