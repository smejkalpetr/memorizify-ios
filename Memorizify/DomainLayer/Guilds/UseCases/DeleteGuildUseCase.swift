//
//  DeleteGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Represents a use case for deleting a guild.
protocol DeleteGuildUseCase {
    
    /// Executes the use case to delete a guild.
    /// - Parameter guild: The guild to delete.
    func execute(_ guild: Guild) async throws
}

/// Handles the use case for deleting a guild.
struct DeleteGuildUseCaseImpl: DeleteGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    private let removeGuildForCurrentUserUseCase: RemoveGuildForCurrentUserUseCase
    private let deleteAllInvitationsForGuildUseCase: DeleteAllInvitationsForGuildUseCase
    
    /// Initializes the use case with the specified dependencies.
    /// - Parameters:
    ///   - guildsRepository: The repository for guild-related operations.
    ///   - removeGuildForCurrentUserUseCase: The use case for removing the guild from the current user's list.
    ///   - deleteAllInvitationsForGuildUseCase: The use case for deleting all invitations related to the guild.
    init(
        guildsRepository: GuildsRepository,
        removeGuildForCurrentUserUseCase: RemoveGuildForCurrentUserUseCase,
        deleteAllInvitationsForGuildUseCase: DeleteAllInvitationsForGuildUseCase
    ) {
        self.guildsRepository = guildsRepository
        self.removeGuildForCurrentUserUseCase = removeGuildForCurrentUserUseCase
        self.deleteAllInvitationsForGuildUseCase = deleteAllInvitationsForGuildUseCase
    }
    
    /// Executes the use case to delete a guild.
    /// - Parameter guild: The guild to delete.
    func execute(_ guild: Guild) async throws {
        try await guildsRepository.delete(guild)
        try await removeGuildForCurrentUserUseCase.execute(guild: guild)
        try await deleteAllInvitationsForGuildUseCase.execute(guild: guild)
    }
}
