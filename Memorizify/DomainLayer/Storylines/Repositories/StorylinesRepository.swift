//
//  StorylinesRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

/// Repository for managing storylines.
protocol StorylinesRepository {
    
    /// Loads all storylines.
    /// - Returns: An array of loaded storylines.
    func loadAll() async throws -> [Storyline]?
    
    /// Updates a storyline.
    /// - Parameter storyline: The storyline to update.
    func update(_ storyline: Storyline) async throws
    
    /// Deletes a storyline.
    /// - Parameter storyline: The storyline to delete.
    func delete(_ storyline: Storyline) async throws
    
    /// Deletes all storylines associated with a user.
    /// - Parameter userUid: The unique identifier of the user.
    func deleteAll(of userUid: String) async throws
}
