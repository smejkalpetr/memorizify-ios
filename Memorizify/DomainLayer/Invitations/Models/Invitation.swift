//
//  Invitation.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

/// Represents an invitation to join a guild.
struct Invitation: Codable, Identifiable, Equatable {
    
    // MARK: Properties
    
    /// Unique identifier for the invitation.
    var id: String {
        return guildId + email + guildName + senderUsername + senderUid
    }
    
    /// Email address of the invited user.
    let email: String
    
    /// Unique identifier of the guild sending the invitation.
    let guildId: String
    
    /// Name of the guild sending the invitation.
    let guildName: String
    
    /// Username of the sender who initiated the invitation.
    let senderUsername: String
    
    /// Unique identifier of the sender who initiated the invitation.
    let senderUid: String
    
    /// Date when the invitation was sent.
    let date: Date
}
