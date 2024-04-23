//
//  ChangePasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

protocol ChangePasswordUseCase {
    func execute(currentPassword: String, newPassword: String) async throws
}

struct ChangePasswordUseCaseImpl: ChangePasswordUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute(currentPassword: String, newPassword: String) async throws {
        try await authenticationRepository.changePassword(from: currentPassword, to: newPassword)
    }
}
