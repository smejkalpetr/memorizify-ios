//
//  LogInUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

/// Handles the login process for existing users.
protocol LogInUseCase {
    
    /// Executes the login process with the provided login data.
    /// - Parameter data: The login data containing user credentials.
    func execute(data: LogInData) async throws
}

/// Implementation of the LogInUseCase protocol.
struct LogInUseCaseImpl: LogInUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes the LogInUseCaseImpl instance.
    /// - Parameter authenticationRepository: The repository for authentication-related operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Executes the login process with the provided login data.
    /// - Parameter data: The login data containing user credentials.
    func execute(data: LogInData) async throws {
        try await authenticationRepository.logIn(with: data)
    }
}
