//
//  SendEmailVerificationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

/// Handles the sending of email verification.
protocol SendEmailVerificationUseCase {
    
    /// Executes the sending of email verification asynchronously.
    func execute() async throws
}

/// Implementation of the SendEmailVerificationUseCase protocol.
struct SendEmailVerificationUseCaseImpl: SendEmailVerificationUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes the SendEmailVerificationUseCaseImpl instance.
    /// - Parameter authenticationRepository: The repository for authentication-related operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Executes the sending of email verification asynchronously.
    func execute() async throws {
        try await authenticationRepository.sendEmailVerification()
    }
}
