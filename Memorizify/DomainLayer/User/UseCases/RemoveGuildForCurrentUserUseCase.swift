//
//  RemoveGuildForCurrentUserUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

protocol RemoveGuildForCurrentUserUseCase {
    func execute(guild: Guild) async throws
}

struct RemoveGuildForCurrentUserUseCaseImpl: RemoveGuildForCurrentUserUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(guild: Guild) async throws {
        try await userRepository.removeGuildForCurrentUser(guild)
    }
}
