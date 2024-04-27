//
//  LogOutUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

/// Handles the logout process for users.
protocol LogOutUseCase {
    
    /// Executes the logout process.
    func execute() throws
}

/// Implementation of the LogOutUseCase protocol.
struct LogOutUseCaseImpl: LogOutUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes the LogOutUseCaseImpl instance.
    /// - Parameter authenticationRepository: The repository for authentication-related operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Executes the logout process.
    func execute() throws {
        try authenticationRepository.logOut()
    }
}
