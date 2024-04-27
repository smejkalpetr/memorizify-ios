//
//  User.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

/// Represents a user in the system.
struct User: Codable {
    
    // MARK: Properties
    
    /// The unique identifier of the user.
    let uid: String
    
    /// The username of the user.
    let username: String
    
    /// The email address of the user.
    let email: String
    
    /// The score of the user.
    let score: Double
    
    /// The identifiers of the guilds the user belongs to.
    let guildIds: [String]?
    
    // MARK: Initialization
    
    /// Initializes a new user instance.
    /// - Parameters:
    ///   - uid: The unique identifier of the user.
    ///   - username: The username of the user.
    ///   - email: The email address of the user.
    ///   - score: The score of the user.
    ///   - guildIds: The identifiers of the guilds the user belongs to.
    init(
        uid: String,
        username: String,
        email: String,
        score: Double,
        guildIds: [String]? = nil
    ) {
        self.uid = uid
        self.username = username
        self.email = email
        self.score = score
        self.guildIds = guildIds
    }
    
    /// Initializes a new user instance based on an existing user instance.
    /// - Parameters:
    ///   - copy: The existing user instance to copy from.
    ///   - uid: The new unique identifier of the user.
    ///   - username: The new username of the user.
    ///   - email: The new email address of the user.
    ///   - score: The new score of the user.
    ///   - guildIds: The new identifiers of the guilds the user belongs to.
    init(
        copy: User,
        uid: String? = nil,
        username: String? = nil,
        email: String? = nil,
        score: Double? = nil,
        guildIds: [String]? = nil
    ) {
        self.uid = uid ?? copy.uid
        self.username = username ?? copy.username
        self.email = email ?? copy.email
        self.score = score ?? copy.score
        self.guildIds = guildIds ?? copy.guildIds
    }
}
