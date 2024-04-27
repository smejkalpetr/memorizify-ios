//
//  InvitationsError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Represents errors that can occur during the invitation process.
enum InvitationsError: Error {
    case alreadyMember       // Error when the user is already a member of a guild.
    case noGuildsFound       // Error when no guilds are found.
    case alreadyInvited      // Error when the user is already invited to a guild.
}
