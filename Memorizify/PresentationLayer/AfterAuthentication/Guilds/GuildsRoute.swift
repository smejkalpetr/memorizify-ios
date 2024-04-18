//
//  GuildsRoute.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

enum GuildsRoute {
    case showGuildDetail(Guild)
    case storylineTimer(Storyline, StorylinePage, PomodoroTimer)
}

extension GuildsRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .showGuildDetail(guild):
            hasher.combine(guild.id)
            hasher.combine(guild.name)
            hasher.combine(guild.goal)
        case let .storylineTimer(storyline, page, timer):
            hasher.combine(storyline.id)
            hasher.combine(page.title)
            hasher.combine(page.story)
            hasher.combine(timer.duration)
        }
    }
    
    static func == (lhs: GuildsRoute, rhs: GuildsRoute) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
