//
//  UserRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

/// Repository for managing user data.
protocol UserRepository {
    
    /// Retrieves the current user.
    /// - Returns: The current user.
    func getCurrentUser() async throws -> User
    
    /// Retrieves a user with the specified email.
    /// - Parameter email: The email of the user to retrieve.
    /// - Returns: The user with the specified email.
    func getUser(with email: String) async throws -> User
    
    /// Retrieves a user with the specified UID.
    /// - Parameter uid: The UID of the user to retrieve.
    /// - Returns: The user with the specified UID.
    func getUser(uid: String) async throws -> User
    
    /// Updates user data.
    /// - Parameter user: The updated user data.
    func update(user: User) async throws
    
    /// Removes a guild association for the current user.
    /// - Parameter guild: The guild to remove.
    func removeGuildForCurrentUser(_ guild: Guild) async throws
    
    /// Deletes the specified user.
    /// - Parameter user: The user to delete.
    func delete(user: User) async throws
}
