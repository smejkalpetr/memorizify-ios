//
//  LoadAllStorylinesUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

/// Use case for loading all storylines.
protocol LoadAllStorylinesUseCase {
    
    /// Loads all storylines asynchronously.
    /// - Returns: An array of loaded storylines, or nil if no storylines are found.
    func execute() async throws -> [Storyline]?
}

/// Implementation of the LoadAllStorylinesUseCase protocol.
struct LoadAllStorylinesUseCaseImpl: LoadAllStorylinesUseCase {
    
    private let storylinesRepository: StorylinesRepository
    
    /// Initializes the LoadAllStorylinesUseCaseImpl with a storylines repository.
    /// - Parameter storylinesRepository: The repository for storylines.
    init(storylinesRepository: StorylinesRepository) {
        self.storylinesRepository = storylinesRepository
    }
    
    /// Loads all storylines asynchronously.
    /// - Returns: An array of loaded storylines, or nil if no storylines are found.
    func execute() async throws -> [Storyline]? {
        return try await storylinesRepository.loadAll()
    }
}
