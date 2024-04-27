//
//  ResetPasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

/// Handles the reset password functionality.
protocol ResetPasswordUseCase {
    
    /// Executes the reset password functionality.
    /// - Parameter email: The email address of the user requesting password reset.
    func execute(email: String) async throws
}

/// Implementation of the ResetPasswordUseCase protocol.
struct ResetPasswordUseCaseImpl: ResetPasswordUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes the ResetPasswordUseCaseImpl instance.
    /// - Parameter authenticationRepository: The repository for authentication-related operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Executes the reset password functionality.
    /// - Parameter email: The email address of the user requesting password reset.
    func execute(email: String) async throws {
        try await authenticationRepository.resetPassword(with: email)
    }
}
