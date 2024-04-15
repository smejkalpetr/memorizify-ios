//
//  LoadAllStorylinesUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

protocol LoadAllStorylinesUseCase {
    func execute() async throws -> [Storyline]?
}

struct LoadAllStorylinesUseCaseImpl: LoadAllStorylinesUseCase {
    
    private let storylinesRepository: StorylinesRepository
    
    init(storylinesRepository: StorylinesRepository) {
        self.storylinesRepository = storylinesRepository
    }

    func execute() async throws -> [Storyline]? {
        return try await storylinesRepository.loadAll()
    }
}
