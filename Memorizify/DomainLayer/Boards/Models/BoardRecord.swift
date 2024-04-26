//
//  BoardRecord.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Foundation

struct BoardRecord: Identifiable , Codable {
    
    // MARK: Properties
    
    var id: String {
        uid + username + String(score) + String(isLeader)
    }
    
    let uid: String
    let username: String
    let score: Double
    let isLeader: Bool
    
    var scoreString: String {
        String(score)
    }
    
    // MARK: Initialization
    
    init(
        uid: String,
        username: String,
        score: Double,
        isLeader: Bool = false
    ) {
        self.uid = uid
        self.username = username
        self.score = score
        self.isLeader = isLeader
    }
    
    init(
        copy: BoardRecord,
        uid: String? = nil,
        username: String? = nil,
        score: Double? = nil,
        isLeader: Bool? = nil
    ) {
        self.uid = uid ?? copy.uid
        self.username = username ?? copy.username
        self.score = score ?? copy.score
        self.isLeader = isLeader ?? copy.isLeader
    }
 }
