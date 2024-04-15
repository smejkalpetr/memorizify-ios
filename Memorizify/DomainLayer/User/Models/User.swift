//
//  User.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

struct User: Codable {
    let name: String
    let email: String
    let score: Double
    
    init(name: String, email: String, score: Double) {
        self.name = name
        self.email = email
        self.score = score
    }
    
    init(copy: User, name: String? = nil, email: String? = nil, score: Double? = nil) {
        self.name = name ?? copy.name
        self.email = email ?? copy.email
        self.score = score ?? copy.score
    }
}
