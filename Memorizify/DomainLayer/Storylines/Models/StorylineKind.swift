//
//  StorylineKind.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

// NOTE: The 'RawRepresentable' conformation is here to be able to construct all
//       data of a storyline with initializer by passing 'rawValue'.
enum StorylineKind: RawRepresentable, CaseIterable, Identifiable {
    
    // MARK: Properties
    static let TEST_STORYLINE_RAW_VALUE = "testStoryline"
        
    case testStoryline(StorylineData)
    
    // MARK: Identifiable
    var id: String { self.rawValue }
    
    // MARK: RawRepresentable
    typealias RawValue = String
    
    var rawValue: String {
        switch self {
        case .testStoryline:
            return StorylineKind.TEST_STORYLINE_RAW_VALUE
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case StorylineKind.TEST_STORYLINE_RAW_VALUE:
            self = .testStoryline(TestStoryline())
        default:
            return nil
        }
    }
    
    // MARK: CaseIterable
    static let allCases: [StorylineKind] = [.testStoryline(TestStoryline())]
}
