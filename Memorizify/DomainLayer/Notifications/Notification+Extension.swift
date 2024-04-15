//
//  Notification+Extension.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Foundation

extension Notification {
    static let refreshStorylines = Notification(name: .refreshStorylines)
}

extension Notification.Name {
    static let refreshStorylines = Notification.Name("refresh_storylines")
}

extension Notification.Name {
    var publisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: self)
    }
}
