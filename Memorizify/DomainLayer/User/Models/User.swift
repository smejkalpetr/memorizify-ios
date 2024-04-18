//
//  User.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

struct User: Codable {
    let uid: String
    let name: String
    let nickname: String?
    let email: String
    let score: Double
    let guildIds: [String]?
    
    init(uid: String, name: String, nickname: String?, email: String, score: Double, guildIds: [String]? = nil) {
        self.uid = uid
        self.name = name
        self.nickname = nickname
        self.email = email
        self.score = score
        self.guildIds = guildIds
    }
    
    init(copy: User, uid: String? = nil, name: String? = nil, nickname: String? = nil, email: String? = nil, score: Double? = nil, guildIds: [String]? = nil) {
        self.uid = uid ?? copy.uid
        self.name = name ?? copy.name
        self.nickname = nickname ?? copy.nickname
        self.email = email ?? copy.email
        self.score = score ?? copy.score
        self.guildIds = guildIds ?? copy.guildIds
    }
}
