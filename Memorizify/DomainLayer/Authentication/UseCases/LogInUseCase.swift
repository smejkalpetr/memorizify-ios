//
//  LogInUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

protocol LogInUseCase {
    func execute(data: LogInData) async throws
}

struct LogInUseCaseImpl: LogInUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute(data: LogInData) async throws {
        try await authenticationRepository.logIn(with: data)
    }
}
