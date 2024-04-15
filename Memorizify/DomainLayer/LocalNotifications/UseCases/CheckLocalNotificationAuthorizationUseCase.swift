//
//  CheckNotificationAuthorizationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import UserNotifications

protocol CheckLocalNotificationAuthorizationUseCase {
    func execute()
}

struct CheckLocalNotificationAuthorizationUseCaseImpl: CheckLocalNotificationAuthorizationUseCase {
    
    private let requestLocalNotificationAuthorizationUseCase: RequestLocalNotificationAuthorizationUseCase
    
    init(requestLocalNotificationAuthorizationUseCase: RequestLocalNotificationAuthorizationUseCase) {
        self.requestLocalNotificationAuthorizationUseCase = requestLocalNotificationAuthorizationUseCase
    }
    
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
