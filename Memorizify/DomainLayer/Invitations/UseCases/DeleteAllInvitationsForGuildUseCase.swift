//
//  DeleteAllInvitationsForGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

protocol DeleteAllInvitationsForGuildUseCase {
    func execute(guild: Guild) async throws
}

struct DeleteAllInvitationsForGuildUseCaseImpl: DeleteAllInvitationsForGuildUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    func execute(guild: Guild) async throws {
        try await invitationsRepository.deleteAllForGuild(guild)
    }
}
