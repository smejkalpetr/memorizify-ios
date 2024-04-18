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
        uid + nickname + String(score) + String(isLeader)
    }
    
    let uid: String
    let nickname: String
    let score: Double
    let isLeader: Bool
    
    // MARK: Initialization
    
    init(
        uid: String,
        nickname: String,
        score: Double,
        isLeader: Bool = false
    ) {
        self.uid = uid
        self.nickname = nickname
        self.score = score
        self.isLeader = isLeader
    }
    
    init(
        copy: BoardRecord,
        uid: String? = nil,
        nickname: String? = nil,
        score: Double? = nil,
        isLeader: Bool? = nil
    ) {
        self.uid = uid ?? copy.uid
        self.nickname = nickname ?? copy.nickname
        self.score = score ?? copy.score
        self.isLeader = isLeader ?? copy.isLeader
    }
 }
