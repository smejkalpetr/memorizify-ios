//
//  SignUpUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

protocol SignUpUseCase {
    func execute(data: SignUpData) async throws
}

struct SignUpUseCaseImpl: SignUpUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    private let sendEmailVerificationUseCase: SendEmailVerificationUseCase
    
    init(
        authenticationRepository: AuthenticationRepository,
        sendEmailVerificationUseCase: SendEmailVerificationUseCase
    ) {
        self.authenticationRepository = authenticationRepository
        self.sendEmailVerificationUseCase = sendEmailVerificationUseCase
    }
    
    func execute(data: SignUpData) async throws {
        try await authenticationRepository.signUp(data: data)
        try await sendEmailVerificationUseCase.execute()
    }
}
