//
//  Guild.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

struct Guild: Identifiable, Codable {
    
    // MARK: Properties
    
    var id: String = UUID().uuidString
    let name: String
    let board: Board
    let leaderUid: String
    let goal: TimeInterval
    let storylineKind: StorylineKind
    
    
    // MARK: Initialization
    
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
    
    private enum CodingKeys: String, CodingKey {
        case id, name, board, leaderUid, goal, storylineKind
    }
    
    // Custom encoding
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
    
    func checkIsLeader(userUid: String) -> Bool {
        return userUid == leaderUid
    }
    
    func checkIsMyRecord(userUid: String, record: BoardRecord) -> Bool {
        return record.uid == userUid
    }
}
