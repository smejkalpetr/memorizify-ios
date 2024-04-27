//
//  CreateGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

/// Represents a use case for creating a new guild.
protocol CreateGuildUseCase {
    
    /// Executes the use case to create a new guild.
    /// - Parameters:
    ///   - name: The name of the guild.
    ///   - goal: The goal duration of the guild's storyline.
    ///   - storylineKindRawValue: The raw value of the storyline kind associated with the guild.
    /// - Returns: The unique identifier of the created guild.
    func execute(with name: String, goal: TimeInterval, storylineKindRawValue: String) async throws -> String
}

/// Handles the creation of a new guild.
struct CreateGuildUseCaseImpl: CreateGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    
    /// Initializes the use case with the specified repository.
    /// - Parameter guildsRepository: The repository for guild-related operations.
    init(guildsRepository: GuildsRepository) {
        self.guildsRepository = guildsRepository
    }
    
    /// Executes the use case to create a new guild.
    /// - Parameters:
    ///   - name: The name of the guild.
    ///   - goal: The goal duration of the guild's storyline.
    ///   - storylineKindRawValue: The raw value of the storyline kind associated with the guild.
    /// - Returns: The unique identifier of the created guild.
    func execute(with name: String, goal: TimeInterval, storylineKindRawValue: String) async throws -> String {
        return try await guildsRepository.add(name: name, goal: goal, storylineKindRawValue: storylineKindRawValue)
    }
}
