//
//  Board.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Foundation

/// Represents a board containing records.
struct Board: Identifiable, Codable {
    
    // MARK: Properties
    
    /// Unique identifier for the board.
    var id = UUID()
    
    /// Records contained in the board.
    var records: [BoardRecord]
    
    /// Sorting order of the board.
    var sorted: Sorted = .unsorted
    
    /// Sorting options for the board.
    enum Sorted: String, Codable {
        case scoreAscending
        case scoreDescending
        case usernameAscending
        case usernameDescending
        case unsorted
    }
    
    // MARK: Initialization
    
    /// Initializes a board with records.
    /// - Parameter records: The records to be included in the board.
    init(records: [BoardRecord]) {
        self.records = records
    }
    
    /// Initializes a copy of a board with optionally new records.
    /// - Parameters:
    ///   - copy: The board to copy.
    ///   - records: Optional new records to replace the existing ones.
    init(copy: Board, records: [BoardRecord]? = nil) {
        self.records = records ?? copy.records
    }
    
    // MARK: Codable
    
    /// Coding keys for encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id, records
    }
    
    /// Encodes the board to a decoder.
    /// - Parameter encoder: The encoder to use for encoding.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(records, forKey: .records)
    }
    
    /// Decodes the board from a decoder.
    /// - Parameter decoder: The decoder to use for decoding.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        records = try container.decode([BoardRecord].self, forKey: .records)
        sorted = .unsorted
    }
    
    // MARK: Public
    
    /// Sorts the records in ascending order based on score.
    mutating func sortByScoreAscending() {
        records.sort { $0.score < $1.score }
        sorted = .scoreAscending
    }
    
    /// Sorts the records in descending order based on score.
    mutating func sortByScoreDescending() {
        records.sort { $0.score > $1.score }
        sorted = .scoreDescending
    }
    
    /// Sorts the records in ascending order based on username.
    mutating func sortByUsernameAscending() {
        records.sort { $0.username.lowercased() < $1.username.lowercased() }
        sorted = .usernameAscending
    }
    
    /// Sorts the records in descending order based on username.
    mutating func sortByUsernameDescending() {
        records.sort { $0.username.lowercased() > $1.username.lowercased() }
        sorted = .usernameDescending
    }
}
