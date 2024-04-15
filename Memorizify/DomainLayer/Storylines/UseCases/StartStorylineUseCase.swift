//
//  StartStorylineUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

protocol StartStorylineUseCase {
    func execute(_ storyline: Storyline, delegate: PomodoroTimerDelegate?) throws -> (StorylinePage, PomodoroTimer)
}

// Just for default parameters
extension StartStorylineUseCase {
    func execute(_ storyline: Storyline, delegate: PomodoroTimerDelegate? = nil) throws -> (StorylinePage, PomodoroTimer) {
        return try execute(storyline, delegate: delegate)
    }
}

struct StartStorylineUseCaseImpl: StartStorylineUseCase {
    
    private let createPomodoroTimerUseCase: CreatePomodoroTimerUseCase
    private let getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase
    
    init(createPomodoroTimerUseCase: CreatePomodoroTimerUseCase, getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase) {
        self.createPomodoroTimerUseCase = createPomodoroTimerUseCase
        self.getCurrentStorylinePageUseCase = getCurrentStorylinePageUseCase
    }
    
    func execute(_ storyline: Storyline, delegate: PomodoroTimerDelegate? = nil) throws -> (StorylinePage, PomodoroTimer) {
        let timer = createPomodoroTimerUseCase.execute(duration: storyline.phase == .break ? storyline.breakInterval : storyline.studyInterval)
        timer.delegate = delegate
        
        let page = try getCurrentStorylinePageUseCase.execute(storyline)
        
        return (page, timer)
    }
}
