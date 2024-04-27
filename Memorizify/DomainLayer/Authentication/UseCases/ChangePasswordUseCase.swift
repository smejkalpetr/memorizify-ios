//
//  ChangePasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

/// Manages the functionality to change the user's password.
protocol ChangePasswordUseCase {
    
    /// Executes the password change functionality.
    /// - Parameters:
    ///   - currentPassword: The current password of the user.
    ///   - newPassword: The new password to set for the user.
    func execute(currentPassword: String, newPassword: String) async throws
}

/// Implementation of the ChangePasswordUseCase protocol.
struct ChangePasswordUseCaseImpl: ChangePasswordUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes the ChangePasswordUseCaseImpl instance.
    /// - Parameter authenticationRepository: The repository for authentication-related operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Executes the password change functionality.
    /// - Parameters:
    ///   - currentPassword: The current password of the user.
    ///   - newPassword: The new password to set for the user.
    func execute(currentPassword: String, newPassword: String) async throws {
        try await authenticationRepository.changePassword(from: currentPassword, to: newPassword)
    }
}
