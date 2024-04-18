//
//  LoadMyGuildsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

protocol LoadMyGuildsUseCase {
    func execute() async throws -> [Guild]?
}

struct LoadMyGuildsUseCaseImpl: LoadMyGuildsUseCase {
    
    private let guildsRepository: GuildsRepository
    
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    func execute() async throws -> [Guild]? {
        return try await guildsRepository.getMyGuilds()
    }
}
