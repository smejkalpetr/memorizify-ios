//
//  Storyline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

import Foundation

struct Storyline: Codable, Identifiable {
    let id: String
    let kind: StorylineKind
    let goalHours: TimeInterval
    let goalMinutes: TimeInterval
    let finished: TimeInterval
    let studyInterval: TimeInterval
    let breakInterval: TimeInterval
    var phase: Phase = .study
    
    var goal: TimeInterval {
        goalMinutes + (60 * goalHours)
    }
    
    var isFinished: Bool {
        return finished >= goal && phase == .study
    }
    
    // MARK: Initialization
    
    init(kind: StorylineKind, goalHours: TimeInterval, goalMinutes: TimeInterval, finished: TimeInterval, studyInterval: TimeInterval, breakInterval: TimeInterval, id: String? = nil) {
        self.kind = kind
        self.goalHours = goalHours
        self.goalMinutes = goalMinutes
        self.finished = finished
        self.studyInterval = studyInterval
        self.breakInterval = breakInterval
        self.id = id ?? UUID().uuidString
    }
    
    init(copy: Storyline, kind: StorylineKind? = nil, goalHours: TimeInterval? = nil, goalMinutes: TimeInterval? = nil, finished: TimeInterval? = nil, studyInterval: TimeInterval? = nil, breakInterval: TimeInterval? = nil, id: String? = nil) {
        self.kind = kind ?? copy.kind
        self.goalHours = goalHours ?? copy.goalHours
        self.goalMinutes = goalMinutes ?? copy.goalMinutes
        self.finished = finished ?? copy.finished
        self.studyInterval = studyInterval ?? copy.studyInterval
        self.breakInterval = breakInterval ?? copy.breakInterval
        self.id = id ?? copy.id
    }
    
    // MARK: Codable
    // Coding keys for encoding and decoding
    private enum CodingKeys: String, CodingKey {
        case kind, phase, goalHours, goalMinutes, finished, studyInterval, breakInterval, id
    }
    
    // Custom encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(kind.rawValue, forKey: .kind)
        try container.encode(goalHours, forKey: .goalHours)
        try container.encode(goalMinutes, forKey: .goalMinutes)
        try container.encode(finished, forKey: .finished)
        try container.encode(studyInterval, forKey: .studyInterval)
        try container.encode(breakInterval, forKey: .breakInterval)
        try container.encode(id, forKey: .id)
    }
    
    // Custom decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kindRawValue = try container.decode(StorylineKind.RawValue.self, forKey: .kind)
        guard let kind = StorylineKind(rawValue: kindRawValue) else {
            throw DecodingError.dataCorruptedError(forKey: .kind, in: container, debugDescription: "Invalid StorylineKind value")
        }
        self.kind = kind
        self.goalHours = try container.decode(TimeInterval.self, forKey: .goalHours)
        self.goalMinutes = try container.decode(TimeInterval.self, forKey: .goalMinutes)
        self.finished = try container.decode(TimeInterval.self, forKey: .finished)
        self.studyInterval = try container.decode(TimeInterval.self, forKey: .studyInterval)
        self.breakInterval = try container.decode(TimeInterval.self, forKey: .breakInterval)
        self.id = try container.decode(String.self, forKey: .id)
    }
}
