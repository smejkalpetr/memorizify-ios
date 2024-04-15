//
//  GetCurrentStorylinePageUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

protocol GetCurrentStorylinePageUseCase {
    func execute(_ storyline: Storyline) throws -> StorylinePage
}

struct GetCurrentStorylinePageUseCaseImpl: GetCurrentStorylinePageUseCase {
    
    init() {}
    
    func execute(_ storyline: Storyline) throws -> any StorylinePage {
        switch storyline.kind {
        case let .testStoryline(data):
            return try data.getCurrentPage(finished: storyline.finished, goal: storyline.goal)
        }
    }
}
