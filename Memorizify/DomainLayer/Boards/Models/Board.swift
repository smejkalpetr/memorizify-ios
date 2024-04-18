//
//  Board.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Foundation

struct Board: Identifiable, Codable {
    
    // MARK: Properties
    
    var id = UUID()
    var records: [BoardRecord]
    var sorted: Sorted = .unsorted
    
    enum Sorted: String, Codable {
        case scoreAscending
        case scoreDescending
        case nicknameAscending
        case nicknameDescending
        case unsorted
    }
    
    // MARK: Initialization
    
    init(records: [BoardRecord]) {
        self.records = records
    }
    
    init(copy: Board, records: [BoardRecord]? = nil) {
        self.records = records ?? copy.records
    }
    
    // MARK: Codable
    // This is here to exclude 'sorted' property from being encoded/decoded

    enum CodingKeys: String, CodingKey {
        case id, records
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(records, forKey: .records)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        records = try container.decode([BoardRecord].self, forKey: .records)
        sorted = .unsorted
    }
    
    // MARK: Public
    
    mutating func sortByScoreAscending() {
        records.sort { $0.score < $1.score }
        sorted = .scoreAscending
    }
    
    mutating func sortByScoreDescending() {
        records.sort { $0.score > $1.score }
        sorted = .scoreDescending
    }
    
    mutating func sortByNicknameAscending() {
        records.sort { $0.nickname.lowercased() < $1.nickname.lowercased() }
        sorted = .nicknameAscending
    }
    
    mutating func sortByNicknameDescending() {
        records.sort { $0.nickname.lowercased() > $1.nickname.lowercased() }
        sorted = .nicknameDescending
    }
}
