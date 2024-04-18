//
//  SendGuildInvitationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

protocol SendGuildInvitationUseCase {
    func execute(to email: String, guildId: String, guildName: String, at date: Date) async throws
}

struct SendGuildInvitationUseCaseImpl: SendGuildInvitationUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    func execute(to email: String, guildId: String, guildName: String, at date: Date) async throws {
        try await invitationsRepository.add(to: email, guildId: guildId, guildName: guildName, at: date)
    }
}
