//
//  IsUserLoggedInUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

/// Checks if the user is currently logged in.
protocol IsUserLoggedInUseCase {
    
    /// Checks if the user is currently logged in.
    /// - Returns: Returns true if the user is logged in, otherwise false.
    func execute() -> Bool
}

/// Implementation of the IsUserLoggedInUseCase protocol.
struct IsUserLoggedInUseCaseImpl: IsUserLoggedInUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes the IsUserLoggedInUseCaseImpl instance.
    /// - Parameter authenticationRepository: The repository for authentication-related operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Checks if the user is currently logged in.
    /// - Returns: Returns true if the user is logged in, otherwise false.
    func execute() -> Bool {
        return authenticationRepository.isUserLoggedIn()
    }
}
