//
//  ResetPasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

protocol ResetPasswordUseCase {
    func execute(email: String) async throws
}

struct ResetPasswordUseCaseImpl: ResetPasswordUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute(email: String) async throws {
        try await authenticationRepository.resetPassword(with: email)
    }
}
