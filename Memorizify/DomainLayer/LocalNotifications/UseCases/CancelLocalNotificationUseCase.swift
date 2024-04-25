//
//  CancelLocalNotificationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 25.04.2024.
//

import UserNotifications

protocol CancelLocalNotificationUseCase {
    func execute(identifier: String)
}

struct CancelLocalNotificationUseCaseImpl: CancelLocalNotificationUseCase {
    
    init() {}
    
    func execute(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
