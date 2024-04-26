//
//  Invitation.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

struct Invitation: Codable, Identifiable, Equatable {
    var id: String {
        guildId + email + guildName + senderUsername + senderUid
    }
    
    let email: String
    let guildId: String
    let guildName: String
    let senderUsername: String
    let senderUid: String
    let date: Date
}
