//
//  SaveStorylineUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

/// Use case for saving a storyline.
protocol SaveStorylineUseCase {
    
    /// Saves the provided storyline asynchronously.
    /// - Parameter storyline: The storyline to be saved.
    func execute(_ storyline: Storyline) async throws
}

/// Implementation of the SaveStorylineUseCase protocol.
struct SaveStorylineUseCaseImpl: SaveStorylineUseCase {
    
    private let storylinesRepository: StorylinesRepository
    
    /// Initializes the SaveStorylineUseCaseImpl with a storylines repository.
    /// - Parameter storylinesRepository: The repository for storylines.
    init(storylinesRepository: StorylinesRepository) {
        self.storylinesRepository = storylinesRepository
    }
    
    /// Saves the provided storyline asynchronously.
    /// - Parameter storyline: The storyline to be saved.
    func execute(_ storyline: Storyline) async throws {
        try await storylinesRepository.update(storyline)
    }
}
