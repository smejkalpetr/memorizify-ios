//
//  Storyline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

import Foundation

/// Represents a storyline in the app.
struct Storyline: Identifiable {
    
    // MARK: Properties
    
    /// The unique identifier of the storyline.
    let id: String
    
    /// The type of the storyline.
    let kind: StorylineKind
    
    /// The goal duration of the storyline in hours.
    let goalHours: TimeInterval
    
    /// The goal duration of the storyline in minutes.
    let goalMinutes: TimeInterval
    
    /// The duration of the storyline that has been completed.
    let finished: TimeInterval
    
    /// The duration of study interval in seconds.
    let studyInterval: TimeInterval
    
    /// The duration of break interval in seconds.
    let breakInterval: TimeInterval
    
    /// The guild associated with the storyline, if any.
    let guild: Guild?
    
    /// The current phase of the storyline.
    var phase: Phase = .study
    
    /// The total goal duration of the storyline.
    var goal: TimeInterval {
        goalMinutes + (60 * goalHours)
    }
    
    /// A Boolean value indicating whether the storyline is finished.
    var isFinished: Bool {
        return finished >= goal && phase == .study
    }
    
    // MARK: Initialization
    
    /// Initializes a new Storyline instance.
    /// - Parameters:
    ///   - kind: The type of the storyline.
    ///   - goalHours: The goal duration of the storyline in hours.
    ///   - goalMinutes: The goal duration of the storyline in minutes.
    ///   - finished: The duration of the storyline that has been completed.
    ///   - studyInterval: The duration of study interval in seconds.
    ///   - breakInterval: The duration of break interval in seconds.
    ///   - id: The unique identifier of the storyline.
    ///   - guild: The guild associated with the storyline, if any.
    init(
        kind: StorylineKind,
        goalHours: TimeInterval,
        goalMinutes: TimeInterval,
        finished: TimeInterval,
        studyInterval: TimeInterval,
        breakInterval: TimeInterval,
        id: String? = nil,
        guild: Guild? = nil
    ) {
        self.kind = kind
        self.goalHours = goalHours
        self.goalMinutes = goalMinutes
        self.finished = finished
        self.studyInterval = studyInterval
        self.breakInterval = breakInterval
        self.id = id ?? UUID().uuidString
        self.guild = guild
    }
    
    /// Initializes a new Storyline instance as a copy of another storyline with optional modifications.
    /// - Parameters:
    ///   - copy: The storyline to copy from.
    ///   - kind: The type of the storyline.
    ///   - goalHours: The goal duration of the storyline in hours.
    ///   - goalMinutes: The goal duration of the storyline in minutes.
    ///   - finished: The duration of the storyline that has been completed.
    ///   - studyInterval: The duration of study interval in seconds.
    ///   - breakInterval: The duration of break interval in seconds.
    ///   - id: The unique identifier of the storyline.
    ///   - guild: The guild associated with the storyline, if any.
    init(
        copy: Storyline,
        kind: StorylineKind? = nil,
        goalHours: TimeInterval? = nil,
        goalMinutes: TimeInterval? = nil,
        finished: TimeInterval? = nil,
        studyInterval: TimeInterval? = nil,
        breakInterval: TimeInterval? = nil,
        id: String? = nil,
        guild: Guild? = nil
    ) {
        self.kind = kind ?? copy.kind
        self.goalHours = goalHours ?? copy.goalHours
        self.goalMinutes = goalMinutes ?? copy.goalMinutes
        self.finished = finished ?? copy.finished
        self.studyInterval = studyInterval ?? copy.studyInterval
        self.breakInterval = breakInterval ?? copy.breakInterval
        self.id = id ?? copy.id
        self.guild = guild ?? copy.guild
    }
    
}

extension Storyline: Codable {
    
    // MARK: Codable
    
    /// Represents the coding keys used for encoding and decoding.
    private enum CodingKeys: String, CodingKey {
        case kind, phase, goalHours, goalMinutes, finished, studyInterval, breakInterval, id
    }
    
    // Custom encoding
    
    /// Encodes the storyline into a format suitable for writing to a file.
    /// - Parameter encoder: The encoder to use for encoding the storyline.
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
    
    /// Initializes a new Storyline instance by decoding data from the given decoder.
    /// - Parameter decoder: The decoder to read data from.
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
        self.guild = nil
    }
}
