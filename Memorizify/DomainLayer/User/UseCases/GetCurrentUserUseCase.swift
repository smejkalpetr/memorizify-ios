//
//  GetCurrentUserUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

/// Retrieves the current user information.
protocol GetCurrentUserUseCase {
    
    /// Executes the retrieval of the current user information.
    /// - Returns: The current user information.
    func execute() async throws -> User
}

/// Implementation of the GetCurrentUserUseCase protocol.
struct GetCurrentUserUseCaseImpl: GetCurrentUserUseCase {
    
    private let userRepository: UserRepository
    
    /// Initializes the GetCurrentUserUseCaseImpl instance.
    /// - Parameter userRepository: The repository for accessing user data.
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    /// Executes the retrieval of the current user information.
    /// - Returns: The current user information.
    func execute() async throws -> User {
        return try await userRepository.getCurrentUser()
    }
}
