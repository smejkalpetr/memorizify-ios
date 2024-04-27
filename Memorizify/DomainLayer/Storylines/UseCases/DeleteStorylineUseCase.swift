//
//  DeleteStorylineUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

/// Use case for deleting a storyline.
protocol DeleteStorylineUseCase {
    
    /// Deletes a storyline asynchronously.
    /// - Parameter storyline: The storyline to be deleted.
    func execute(_ storyline: Storyline) async throws
}

/// Implementation of the DeleteStorylineUseCase protocol.
struct DeleteStorylineUseCaseImpl: DeleteStorylineUseCase {
    
    private let storylinesRepository: StorylinesRepository
    
    /// Initializes the DeleteStorylineUseCaseImpl with a storylines repository.
    /// - Parameter storylinesRepository: The repository for storylines.
    init(storylinesRepository: StorylinesRepository) {
        self.storylinesRepository = storylinesRepository
    }
    
    /// Deletes a storyline asynchronously.
    /// - Parameter storyline: The storyline to be deleted.
    func execute(_ storyline: Storyline) async throws {
        try await storylinesRepository.delete(storyline)
    }
}
