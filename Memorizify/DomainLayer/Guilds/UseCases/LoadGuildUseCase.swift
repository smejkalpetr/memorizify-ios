//
//  LoadGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.04.2024.
//

/// Represents a use case for loading a specific guild.
protocol LoadGuildUseCase {
    
    /// Executes the use case to load the details of a specific guild.
    /// - Parameter guild: The guild to load.
    /// - Returns: The details of the loaded guild.
    func execute(guild: Guild) async throws -> Guild
}

/// Handles the use case for loading a specific guild.
struct LoadGuildUseCaseImpl: LoadGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    
    /// Initializes the use case with the specified repository.
    /// - Parameter guildsRepository: The repository for guild-related operations.
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    /// Executes the use case to load the details of a specific guild.
    /// - Parameter guild: The guild to load.
    /// - Returns: The details of the loaded guild.
    func execute(guild: Guild) async throws -> Guild {
        return try await guildsRepository.load(guild)
    }
}
