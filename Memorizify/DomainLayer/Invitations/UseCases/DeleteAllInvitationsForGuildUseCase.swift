//
//  DeleteAllInvitationsForGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

/// Handles the deletion of all invitations for a specific guild.
protocol DeleteAllInvitationsForGuildUseCase {
    
    /// Deletes all invitations for the specified guild.
    /// - Parameter guild: The guild for which invitations should be deleted.
    func execute(guild: Guild) async throws
}

/// Default implementation of `DeleteAllInvitationsForGuildUseCase`.
struct DeleteAllInvitationsForGuildUseCaseImpl: DeleteAllInvitationsForGuildUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    /// Initializes the use case with the specified invitations repository.
    /// - Parameter invitationsRepository: The repository handling invitations.
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    /// Deletes all invitations for the specified guild.
    /// - Parameter guild: The guild for which invitations should be deleted.
    func execute(guild: Guild) async throws {
        try await invitationsRepository.deleteAllForGuild(guild)
    }
}
