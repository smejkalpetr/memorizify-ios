//
//  MembersRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.04.2024.
//

/// Represents a repository for managing guild members.
protocol MembersRepository {
    
    /// Removes a member from the specified guild.
    /// - Parameters:
    ///   - uid: The unique identifier of the member to remove.
    ///   - guild: The guild from which to remove the member.
    func remove(with uid: String, from guild: Guild) async throws
    
    /// Updates a member's score within the specified guild.
    /// - Parameters:
    ///   - score: The new score for the member.
    ///   - guild: The guild to which the member belongs.
    func updateScore(to score: Double, in guild: Guild) async throws
}
