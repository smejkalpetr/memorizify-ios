//
//  CheckPasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

/// Manages the functionality to check the strength of a password.
protocol CheckPasswordUseCase {
    
    /// Executes the password strength checking functionality.
    /// - Parameter password: The password to check.
    func execute(password: String) async throws
}

/// Implementation of the CheckPasswordUseCase protocol.
struct CheckPasswordUseCaseImpl: CheckPasswordUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes the CheckPasswordUseCaseImpl instance.
    /// - Parameter authenticationRepository: The repository for authentication-related operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Executes the password strength checking functionality.
    /// - Parameter password: The password to check.
    func execute(password: String) async throws {
        try await authenticationRepository.checkPassword(password)
    }
}
