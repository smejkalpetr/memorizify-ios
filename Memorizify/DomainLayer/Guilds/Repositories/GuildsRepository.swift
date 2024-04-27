//
//  GuildsRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

/// Represents a repository for managing guilds.
protocol GuildsRepository {
    
    /// Adds a new guild with the specified parameters.
    /// - Parameters:
    ///   - name: The name of the guild.
    ///   - goal: The goal of the guild.
    ///   - storylineKindRawValue: The raw value of the storyline kind.
    /// - Returns: The ID of the newly created guild.
    func add(name: String, goal: TimeInterval, storylineKindRawValue: String) async throws -> String
    
    /// Retrieves all guilds associated with the specified email.
    /// - Parameter email: The email of the user.
    /// - Returns: An array of guilds associated with the user's email.
    func getAllGuildsForUser(with email: String) async throws -> [Guild]?
    
    /// Retrieves all guilds associated with the current user.
    /// - Returns: An array of guilds associated with the current user.
    func getMyGuilds() async throws -> [Guild]?
    
    /// Retrieves all guilds.
    /// - Returns: An array of all guilds.
    func getAllGuilds() async throws -> [Guild]?
    
    /// Updates the specified guild.
    /// - Parameter guild: The guild to update.
    func update(_ guild: Guild) async throws
    
    /// Deletes the specified guild.
    /// - Parameter guild: The guild to delete.
    func delete(_ guild: Guild) async throws
    
    /// Adds the specified guild.
    /// - Parameter guild: The guild to add.
    func add(_ guild: Guild) async throws
    
    /// Loads the specified guild.
    /// - Parameter guild: The guild to load.
    /// - Returns: The loaded guild.
    func load(_ guild: Guild) async throws -> Guild
    
    /// Deletes all guilds associated with the specified user UID.
    /// - Parameter userUid: The user UID.
    func deleteAll(of userUid: String) async throws
}
