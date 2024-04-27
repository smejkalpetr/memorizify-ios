//
//  CheckNotificationAuthorizationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import UserNotifications

/// Checks the authorization status for local notifications.
protocol CheckLocalNotificationAuthorizationUseCase {
    
    /// Executes the check for local notification authorization status.
    func execute()
}

/// Implementation of the CheckLocalNotificationAuthorizationUseCase protocol.
struct CheckLocalNotificationAuthorizationUseCaseImpl: CheckLocalNotificationAuthorizationUseCase {
    
    private let requestLocalNotificationAuthorizationUseCase: RequestLocalNotificationAuthorizationUseCase
    
    /// Initializes the CheckLocalNotificationAuthorizationUseCaseImpl instance.
    /// - Parameter requestLocalNotificationAuthorizationUseCase: The use case for requesting notification authorization.
    init(requestLocalNotificationAuthorizationUseCase: RequestLocalNotificationAuthorizationUseCase) {
        self.requestLocalNotificationAuthorizationUseCase = requestLocalNotificationAuthorizationUseCase
    }
    
    /// Executes the check for local notification authorization status.
    func execute() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                requestLocalNotificationAuthorizationUseCase.execute()
            default:
                break
            }
        }
    }
}
