//
//  HomeRoute.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import Foundation

enum HomeRoute {
    case plainTimer(studyInterval: TimeInterval, breakInterval: TimeInterval)
    case storylineTimer(Storyline, StorylinePage, PomodoroTimer)
}

extension HomeRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .plainTimer(studyInterval, breakInterval):
            hasher.combine(studyInterval)
            hasher.combine(breakInterval)
        case let .storylineTimer(storyline, page, timer):
            hasher.combine(storyline.id)
            hasher.combine(page.title)
            hasher.combine(page.story)
            hasher.combine(timer.duration)
        }
    }
    
    static func == (lhs: HomeRoute, rhs: HomeRoute) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
