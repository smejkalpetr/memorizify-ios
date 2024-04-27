//
//  LoadMyGuildsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Represents a use case for loading guilds associated with the current user.
protocol LoadMyGuildsUseCase {
    
    /// Executes the use case to load guilds associated with the current user.
    /// - Returns: An array of guilds associated with the current user, or nil if no guilds are found.
    func execute() async throws -> [Guild]?
}

/// Handles the use case for loading guilds associated with the current user.
struct LoadMyGuildsUseCaseImpl: LoadMyGuildsUseCase {
    
    private let guildsRepository: GuildsRepository
    
    /// Initializes the use case with the specified repository.
    /// - Parameter guildsRepository: The repository for guild-related operations.
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    /// Executes the use case to load guilds associated with the current user.
    /// - Returns: An array of guilds associated with the current user, or nil if no guilds are found.
    func execute() async throws -> [Guild]? {
        return try await guildsRepository.getMyGuilds()
    }
}
