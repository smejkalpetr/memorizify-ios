//
//  SendEmailVerificationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

protocol SendEmailVerificationUseCase {
    func execute() async throws
}

struct SendEmailVerificationUseCaseImpl: SendEmailVerificationUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute() async throws {
        try await authenticationRepository.sendEmailVerification()
    }
}
