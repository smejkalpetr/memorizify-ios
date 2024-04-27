//
//  StorylineKind.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

import Foundation

// NOTE: The 'RawRepresentable' conformation is here to be able to construct all
//       data of a storyline with initializer by passing 'rawValue'.

/// Represents the type of storyline.
enum StorylineKind: RawRepresentable, CaseIterable, Identifiable {
    
    // MARK: Properties
    
    /// The raw value for the test storyline.
    static let TEST_STORYLINE_RAW_VALUE: LocalizedStringResource = "testStoryline"
    
    /// The raw value for the plain timer storyline.
    static let PLAIN_TIMER_STORYLINE_RAW_VALUE: LocalizedStringResource = "testStoryline"
    
    /// Represents a test storyline.
    case testStoryline(StorylineData)
    
    /// Represents a plain timer storyline.
    case plainTimerStoryline(StorylineData)
    
    // MARK: Public
    
    /// Returns the description of the storyline.
    /// - Returns: The description of the storyline.
    func getDescription() -> String {
        switch self {
        case let .testStoryline(storylineData):
            return storylineData.description
        case let .plainTimerStoryline(storylineData):
            return storylineData.description
        }
    }
    
    // MARK: Identifiable
    
    /// The identifier of the storyline.
    var id: String { self.rawValue }
    
    // MARK: RawRepresentable
    
    typealias RawValue = String
    
    /// The raw value of the storyline.
    var rawValue: String {
        switch self {
        case .testStoryline:
            return String(localized: StorylineKind.TEST_STORYLINE_RAW_VALUE)
        case .plainTimerStoryline:
            return String(localized: StorylineKind.PLAIN_TIMER_STORYLINE_RAW_VALUE)
        }
    }
    
    /// Initializes a storyline kind from its raw value.
    /// - Parameter rawValue: The raw value of the storyline.
    init?(rawValue: String) {
        switch rawValue {
        case String(localized: StorylineKind.TEST_STORYLINE_RAW_VALUE):
            self = .testStoryline(TestStoryline())
        case String(localized: StorylineKind.PLAIN_TIMER_STORYLINE_RAW_VALUE):
            self = .plainTimerStoryline(PlainTimerStoryline())
        default:
            return nil
        }
    }
    
    // MARK: CaseIterable
    
    /// All cases of the storyline kind.
    static let allCases: [StorylineKind] = [
        // Don't put PlainTimerStoryline here becuase it would then
        // show in storyline selection on the Storylines tab
        .testStoryline(TestStoryline())
    ]
}
