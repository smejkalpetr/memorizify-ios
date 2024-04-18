//
//  UpdateGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

protocol UpdateGuildUseCase {
    func execute(guild: Guild) async throws
}

struct UpdateGuildUseCaseImpl: UpdateGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    func execute(guild: Guild) async throws {
        try await guildsRepository.update(guild)
    }
}
