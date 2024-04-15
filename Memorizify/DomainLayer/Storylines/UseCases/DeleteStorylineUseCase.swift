//
//  DeleteStorylineUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

protocol DeleteStorylineUseCase {
    func execute(_ storyline: Storyline) async throws
}

struct DeleteStorylineUseCaseImpl: DeleteStorylineUseCase {
    
    private let storylinesRepository: StorylinesRepository
    
    init(storylinesRepository: StorylinesRepository) {
        self.storylinesRepository = storylinesRepository
    }
    
    func execute(_ storyline: Storyline) async throws {
        try await storylinesRepository.delete(storyline)
    }
}
