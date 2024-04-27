//
//  RequestLocalNotificationAuthorizationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import UserNotifications

/// Handles the request for local notification authorization.
protocol RequestLocalNotificationAuthorizationUseCase {
    
    /// Executes the request for local notification authorization.
    func execute()
}

/// Implementation of the RequestLocalNotificationAuthorizationUseCase protocol.
struct RequestLocalNotificationAuthorizationUseCaseImpl: RequestLocalNotificationAuthorizationUseCase {
    
    init() {}
    
    /// Executes the request for local notification authorization.
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
