//
//  Notification+Extension.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Foundation

extension Notification {
    static let refreshStorylines = Notification(name: .refreshStorylines)
    static let refreshGuilds = Notification(name: .refreshGuilds)
    static let refreshGuildDetail = Notification(name: .refreshGuildDetail)
    static let refreshInvitations = Notification(name: .refreshInvitations)
}

extension Notification.Name {
    static let refreshStorylines = Notification.Name("refresh_storylines")
    static let refreshGuilds = Notification.Name("refresh_guilds")
    static let refreshGuildDetail = Notification.Name("refresh_guild_detail")
    static let refreshInvitations = Notification.Name("refresh_invitations")
}

extension Notification.Name {
    var publisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: self)
    }
}
