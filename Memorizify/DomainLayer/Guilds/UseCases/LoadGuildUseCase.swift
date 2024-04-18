//
//  LoadGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.04.2024.
//

protocol LoadGuildUseCase {
    func execute(guild: Guild) async throws -> Guild
}

struct LoadGuildUseCaseImpl: LoadGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    func execute(guild: Guild) async throws -> Guild {
        return try await guildsRepository.load(guild)
    }
}
