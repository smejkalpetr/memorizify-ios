//
//  SignUpUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

/// Handles the sign-up process for new users.
protocol SignUpUseCase {
    
    /// Executes the sign-up process with the provided sign-up data.
    /// - Parameter data: The sign-up data containing user information.
    func execute(data: SignUpData) async throws
}

/// Implementation of the SignUpUseCase protocol.
struct SignUpUseCaseImpl: SignUpUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    private let sendEmailVerificationUseCase: SendEmailVerificationUseCase
    
    /// Initializes the SignUpUseCaseImpl instance.
    /// - Parameters:
    ///   - authenticationRepository: The repository for authentication-related operations.
    ///   - sendEmailVerificationUseCase: The use case for sending email verification.
    init(
        authenticationRepository: AuthenticationRepository,
        sendEmailVerificationUseCase: SendEmailVerificationUseCase
    ) {
        self.authenticationRepository = authenticationRepository
        self.sendEmailVerificationUseCase = sendEmailVerificationUseCase
    }
    
    /// Executes the sign-up process with the provided sign-up data.
    /// - Parameter data: The sign-up data containing user information.
    func execute(data: SignUpData) async throws {
        try await authenticationRepository.signUp(data: data)
        try await sendEmailVerificationUseCase.execute()
    }
}
