//
//  SendGuildInvitationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

/// Handles the sending of guild invitations.
protocol SendGuildInvitationUseCase {
    
    /// Sends a guild invitation to the specified email address.
    /// - Parameters:
    ///   - email: The email address of the recipient.
    ///   - guildId: The unique identifier of the guild.
    ///   - guildName: The name of the guild.
    ///   - date: The date when the invitation is sent.
    func execute(to email: String, guildId: String, guildName: String, at date: Date) async throws
}

/// Default implementation of `SendGuildInvitationUseCase`.
struct SendGuildInvitationUseCaseImpl: SendGuildInvitationUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    /// Initializes the use case with the specified invitations repository.
    /// - Parameter invitationsRepository: The repository handling invitations.
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    /// Sends a guild invitation to the specified email address.
    /// - Parameters:
    ///   - email: The email address of the recipient.
    ///   - guildId: The unique identifier of the guild.
    ///   - guildName: The name of the guild.
    ///   - date: The date when the invitation is sent.
    func execute(to email: String, guildId: String, guildName: String, at date: Date) async throws {
        try await invitationsRepository.add(to: email, guildId: guildId, guildName: guildName, at: date)
    }
}
