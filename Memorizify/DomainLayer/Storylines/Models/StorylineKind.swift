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
    
    /// The raw value for the plain timer storyline.
    static let PLAIN_TIMER_STORYLINE_RAW_VALUE: LocalizedStringResource = "Plain Timer"
    
    /// The raw value for the dragon storyline.
    static let DRAGON_STORYLINE_RAW_VALUE: LocalizedStringResource = "Ember's Tale"
    
    /// The raw value for the turtle storyline.
    static let TURTLE_STORYLINE_RAW_VALUE: LocalizedStringResource = "Tilly's Triumph"
    
    /// The raw value for the flower storyline.
    static let FLOWER_STORYLINE_RAW_VALUE: LocalizedStringResource = "Floral Oddities"
    
    /// Represents a plain timer storyline.
    case plainTimerStoryline(StorylineData)
    
    /// Represents dragon storyline.
    case draagonStoryline(StorylineData)
    
    /// Represents turtle storyline.
    case turtleStoryline(StorylineData)
    
    /// Represents flower storyline.
    case flowerStoryline(StorylineData)
    
    // MARK: Public
    
    /// Returns the description of the storyline.
    /// - Returns: The description of the storyline.
    func getDescription() -> String {
        switch self {
        case let .plainTimerStoryline(storylineData):
            return storylineData.description
        case let .draagonStoryline(storylineData):
            return storylineData.description
        case let .turtleStoryline(storylineData):
            return storylineData.description
        case let .flowerStoryline(storylineData):
            return storylineData.description
        }
    }
    
    /// Returns the short description of the storyline.
    /// - Returns: The short description of the storyline.
    func getShortDescription() -> String {
        switch self {
        case let .plainTimerStoryline(storylineData):
            return storylineData.shortDescription
        case let .draagonStoryline(storylineData):
            return storylineData.shortDescription
        case let .turtleStoryline(storylineData):
            return storylineData.shortDescription
        case let .flowerStoryline(storylineData):
            return storylineData.shortDescription
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
        case .plainTimerStoryline:
            return String(localized: StorylineKind.PLAIN_TIMER_STORYLINE_RAW_VALUE)
        case .draagonStoryline:
            return String(localized: StorylineKind.DRAGON_STORYLINE_RAW_VALUE)
        case .turtleStoryline:
            return String(localized: StorylineKind.TURTLE_STORYLINE_RAW_VALUE)
        case .flowerStoryline:
            return String(localized: StorylineKind.FLOWER_STORYLINE_RAW_VALUE)
        }
    }
    
    /// Initializes a storyline kind from its raw value.
    /// - Parameter rawValue: The raw value of the storyline.
    init?(rawValue: String) {
        switch rawValue {
        case String(localized: StorylineKind.PLAIN_TIMER_STORYLINE_RAW_VALUE):
            self = .plainTimerStoryline(PlainTimerStoryline())
        case String(localized: StorylineKind.DRAGON_STORYLINE_RAW_VALUE):
            self = .draagonStoryline(DragonStoryline())
        case String(localized: StorylineKind.TURTLE_STORYLINE_RAW_VALUE):
            self = .turtleStoryline(TurtleStoryline())
        case String(localized: StorylineKind.FLOWER_STORYLINE_RAW_VALUE):
            self = .flowerStoryline(FlowerStoryline())
        default:
            return nil
        }
    }
    
    // MARK: CaseIterable
    
    /// All cases of the storyline kind.
    static let allCases: [StorylineKind] = [
        // Don't put PlainTimerStoryline here becuase it would then
        // show in storyline selection on the Storylines tab
        .draagonStoryline(DragonStoryline()),
        .turtleStoryline(TurtleStoryline()),
        .flowerStoryline(FlowerStoryline())
    ]
}
