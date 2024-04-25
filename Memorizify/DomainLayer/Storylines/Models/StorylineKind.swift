//
//  StorylineKind.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

import Foundation

// NOTE: The 'RawRepresentable' conformation is here to be able to construct all
//       data of a storyline with initializer by passing 'rawValue'.
enum StorylineKind: RawRepresentable, CaseIterable, Identifiable {
    
    // MARK: Properties
    
    static let TEST_STORYLINE_RAW_VALUE: LocalizedStringResource = "testStoryline"
    static let PLAIN_TIMER_STORYLINE_RAW_VALUE: LocalizedStringResource = "testStoryline"
    
    case testStoryline(StorylineData)
    case plainTimerStoryline(StorylineData)
    
    // MARK: Public
    
    func getDescription() -> String {
        switch self {
        case let .testStoryline(storylineData):
            return storylineData.description
        case let .plainTimerStoryline(storylineData):
            return storylineData.description
        }
    }
    
    // MARK: Identifiable
    
    var id: String { self.rawValue }
    
    // MARK: RawRepresentable
    
    typealias RawValue = String
    
    var rawValue: String {
        switch self {
        case .testStoryline:
            return String(localized: StorylineKind.TEST_STORYLINE_RAW_VALUE)
        case .plainTimerStoryline:
            return String(localized: StorylineKind.PLAIN_TIMER_STORYLINE_RAW_VALUE)
        }
    }
    
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
    
    static let allCases: [StorylineKind] = [
        // Don't put PlainTimerStoryline here becuase it would then
        // show in storyline selection on the Storylines tab
        .testStoryline(TestStoryline())
    ]
}
