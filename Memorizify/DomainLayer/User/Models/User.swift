//
//  User.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

struct User: Codable {
    
    // MARK: Properties
    
    let uid: String
    let username: String
    let email: String
    let score: Double
    let guildIds: [String]?
    
    // MARK: Initialization
    
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
