//
//  BoardRecord.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Foundation

/// Represents a record on a leaderboard.
struct BoardRecord: Identifiable , Codable {
    
    // MARK: Properties
    
    /// Unique identifier for the record, composed of various properties.
    var id: String {
        uid + username + String(score) + String(isLeader)
    }
    
    /// User ID associated with the record.
    let uid: String
    
    /// Username associated with the record.
    let username: String
    
    /// Score associated with the record.
    let score: Double
    
    /// Indicates whether the user is a leader.
    let isLeader: Bool
    
    /// String representation of the score.
    var scoreString: String {
        String(score)
    }
    
    // MARK: Initialization
    
    /// Initializes a new board record.
    /// - Parameters:
    ///   - uid: The user ID.
    ///   - username: The username.
    ///   - score: The score.
    ///   - isLeader: Indicates whether the user is a leader.
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
    
    /// Initializes a copy of a board record with optionally new values.
    /// - Parameters:
    ///   - copy: The record to copy.
    ///   - uid: Optional new user ID.
    ///   - username: Optional new username.
    ///   - score: Optional new score.
    ///   - isLeader: Optional new leader status.
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
