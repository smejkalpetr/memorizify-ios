//
//  RemoveGuildForCurrentUserUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

/// Removes a guild for the current user.
protocol RemoveGuildForCurrentUserUseCase {
    
    /// Executes the removal of the specified guild for the current user.
    /// - Parameter guild: The guild to be removed.
    func execute(guild: Guild) async throws
}

/// Implementation of the RemoveGuildForCurrentUserUseCase protocol.
struct RemoveGuildForCurrentUserUseCaseImpl: RemoveGuildForCurrentUserUseCase {
    
    private let userRepository: UserRepository
    
    /// Initializes the RemoveGuildForCurrentUserUseCaseImpl instance.
    /// - Parameter userRepository: The repository for accessing user data.
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    /// Executes the removal of the specified guild for the current user.
    /// - Parameter guild: The guild to be removed.
    func execute(guild: Guild) async throws {
        try await userRepository.removeGuildForCurrentUser(guild)
    }
}
