//
//  GetCurrentUserUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

protocol GetCurrentUserUseCase {
    func execute() async throws -> User
}

struct GetCurrentUserUseCaseImpl: GetCurrentUserUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> User {
        return try await userRepository.getCurrentUser()
    }
}
