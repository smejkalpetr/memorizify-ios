//
//  Guild.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

/// Represents a guild in the game.
struct Guild: Identifiable, Codable {
    
    // MARK: Properties
    
    /// Unique identifier for the guild.
    var id: String = UUID().uuidString
    
    /// The name of the guild.
    let name: String
    
    /// The board associated with the guild.
    let board: Board
    
    /// The UID of the leader of the guild.
    let leaderUid: String
    
    /// The goal duration for the guild's activities.
    let goal: TimeInterval
    
    /// The type of storyline associated with the guild.
    let storylineKind: StorylineKind
    
    
    // MARK: Initialization
    
    /// Initializes a new guild.
    /// - Parameters:
    ///   - id: The ID of the guild.
    ///   - name: The name of the guild.
    ///   - board: The associated board.
    ///   - leaderUid: The UID of the guild leader.
    ///   - goal: The goal duration.
    ///   - storylineKind: The type of storyline.
    init(
        id: String? = nil,
        name: String,
        board: Board,
        leaderUid: String,
        goal: TimeInterval,
        storylineKind: StorylineKind
    ) {
        self.id = id ?? UUID().uuidString
        self.name = name
        self.board = board
        self.leaderUid = leaderUid
        self.goal = goal
        self.storylineKind = storylineKind
    }
    
    /// Initializes a new guild by copying another guild.
    /// - Parameters:
    ///   - copy: The guild to copy from.
    ///   - id: The ID of the new guild.
    ///   - name: The name of the new guild.
    ///   - board: The associated board of the new guild.
    ///   - leaderUid: The UID of the leader of the new guild.
    ///   - goal: The goal duration for the new guild.
    ///   - storylineKind: The type of storyline for the new guild.
    init(
        copy: Guild,
        id: String? = nil,
        name: String? = nil,
        board: Board? = nil,
        leaderUid: String? = nil,
        goal: TimeInterval? = nil,
        storylineKind: StorylineKind? = nil
    ) {
        self.id = id ?? copy.id
        self.name = name ?? copy.name
        self.board = board ?? copy.board
        self.leaderUid = leaderUid ?? copy.leaderUid
        self.goal = goal ?? copy.goal
        self.storylineKind = storylineKind ?? copy.storylineKind
    }
    
    // MARK: Codable
    
    /// Coding keys for encoding and decoding.
    private enum CodingKeys: String, CodingKey {
        case id, name, board, leaderUid, goal, storylineKind
    }
    
    // Custom encoding
    
    /// Encodes the guild to a coder.
    /// - Parameter encoder: The encoder to use for encoding.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(board, forKey: .board)
        try container.encode(leaderUid, forKey: .leaderUid)
        try container.encode(goal, forKey: .goal)
        try container.encode(storylineKind.rawValue, forKey: .storylineKind)
    }
    
    // Custom decoding
    
    /// Initializes a guild by decoding from a decoder.
    /// - Parameter decoder: The decoder to decode from.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.board = try container.decode(Board.self, forKey: .board)
        self.leaderUid = try container.decode(String.self, forKey: .leaderUid)
        self.goal = try container.decode(TimeInterval.self, forKey: .goal)
        let storylineKindRawValue = try container.decode(StorylineKind.RawValue.self, forKey: .storylineKind)
        guard let storylineKind = StorylineKind(rawValue: storylineKindRawValue) else {
            throw DecodingError.dataCorruptedError(forKey: .storylineKind, in: container, debugDescription: "Invalid StorylineKind value")
        }
        self.storylineKind = storylineKind
    }
    
    // MARK: Public
    
    /// Checks if a user is the leader of the guild.
    /// - Parameter userUid: The UID of the user.
    /// - Returns: True if the user is the leader, false otherwise.
    func checkIsLeader(userUid: String) -> Bool {
        return userUid == leaderUid
    }
    
    /// Checks if a record belongs to the user.
    /// - Parameters:
    ///   - userUid: The UID of the user.
    ///   - record: The board record to check.
    /// - Returns: True if the record belongs to the user, false otherwise.
    func checkIsMyRecord(userUid: String, record: BoardRecord) -> Bool {
        return record.uid == userUid
    }
}
