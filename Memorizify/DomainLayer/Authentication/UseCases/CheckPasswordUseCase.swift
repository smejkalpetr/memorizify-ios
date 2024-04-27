//
//  CheckPasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

protocol CheckPasswordUseCase {
    func execute(password: String) async throws
}

struct CheckPasswordUseCaseImpl: CheckPasswordUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute(password: String) async throws {
        try await authenticationRepository.checkPassword(password)
    }
}
