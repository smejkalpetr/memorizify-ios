//
//  RequestLocalNotificationAuthorizationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import UserNotifications

protocol RequestLocalNotificationAuthorizationUseCase {
    func execute()
}

struct RequestLocalNotificationAuthorizationUseCaseImpl: RequestLocalNotificationAuthorizationUseCase {
    
    init() {}
    
    func execute() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting authorization for notifications: \(error.localizedDescription)")
            } else {
                if granted {
                    print("Notification authorization granted")
                } else {
                    print("Notification authorization denied")
                }
            }
        }
    }
}
