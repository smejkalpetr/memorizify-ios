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
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            } else {
                if granted {
                    NSLog("✅ Notification authorization granted (\(#file) on line \(#line))")
                } else {
                    NSLog("⚠️ Notification authorization denied (\(#file) on line \(#line))")
                }
            }
        }
    }
}
