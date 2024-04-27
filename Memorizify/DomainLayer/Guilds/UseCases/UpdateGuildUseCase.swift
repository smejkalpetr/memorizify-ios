//
//  UpdateGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

/// Represents a use case for updating a guild.
protocol UpdateGuildUseCase {
    
    /// Executes the use case to update a guild.
    /// - Parameter guild: The guild to update.
    func execute(guild: Guild) async throws
}

/// Handles the use case for updating a guild.
struct UpdateGuildUseCaseImpl: UpdateGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    
    /// Initializes the use case with the specified repository.
    /// - Parameter guildsRepository: The repository for guild-related operations.
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    /// Executes the use case to update a guild.
    /// - Parameter guild: The guild to update.
    func execute(guild: Guild) async throws {
        try await guildsRepository.update(guild)
    }
}
