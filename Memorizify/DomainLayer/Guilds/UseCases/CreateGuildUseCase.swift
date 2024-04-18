//
//  CreateGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

protocol CreateGuildUseCase {
    func execute(with name: String, goal: TimeInterval, storylineKindRawValue: String) async throws -> String
}

struct CreateGuildUseCaseImpl: CreateGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    func execute(with name: String, goal: TimeInterval, storylineKindRawValue: String) async throws -> String {
        return try await guildsRepository.add(name: name, goal: goal, storylineKindRawValue: storylineKindRawValue)
    }
}
