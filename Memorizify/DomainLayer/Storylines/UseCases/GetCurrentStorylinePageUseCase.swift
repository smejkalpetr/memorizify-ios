//
//  GetCurrentStorylinePageUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

/// Use case for getting the current page of a storyline.
protocol GetCurrentStorylinePageUseCase {
    
    /// Gets the current page of a storyline.
    /// - Parameter storyline: The storyline for which to get the current page.
    /// - Returns: The current page of the storyline.
    func execute(_ storyline: Storyline) throws -> StorylinePage
}

/// Implementation of the GetCurrentStorylinePageUseCase protocol.
struct GetCurrentStorylinePageUseCaseImpl: GetCurrentStorylinePageUseCase {
    
    /// Initializes the GetCurrentStorylinePageUseCaseImpl.
    init() {}
    
    /// Gets the current page of a storyline.
    /// - Parameter storyline: The storyline for which to get the current page.
    /// - Returns: The current page of the storyline.
    func execute(_ storyline: Storyline) throws -> any StorylinePage {
        switch storyline.kind {
        case let .testStoryline(data):
            return try data.getCurrentPage(finished: storyline.finished, goal: storyline.goal)
        case .plainTimerStoryline:
            return PlainTimerStorylinePage()
        }
    }
}
