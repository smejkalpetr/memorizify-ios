//
//  StartStorylineUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

/// Use case for starting a storyline.
protocol StartStorylineUseCase {
    
    /// Starts a storyline.
    /// - Parameters:
    ///   - storyline: The storyline to start.
    ///   - delegate: The delegate for the Pomodoro timer.
    /// - Returns: A tuple containing the current page of the storyline and the Pomodoro timer.
    func execute(_ storyline: Storyline, delegate: PomodoroTimerDelegate?) throws -> (StorylinePage, PomodoroTimer)
}

// Just for default parameters
extension StartStorylineUseCase {
    func execute(_ storyline: Storyline, delegate: PomodoroTimerDelegate? = nil) throws -> (StorylinePage, PomodoroTimer) {
        return try execute(storyline, delegate: delegate)
    }
}

/// Implementation of the StartStorylineUseCase protocol.
struct StartStorylineUseCaseImpl: StartStorylineUseCase {
    
    private let createPomodoroTimerUseCase: CreatePomodoroTimerUseCase
    private let getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase
    
    /// Initializes the StartStorylineUseCaseImpl.
    /// - Parameters:
    ///   - createPomodoroTimerUseCase: The use case for creating a Pomodoro timer.
    ///   - getCurrentStorylinePageUseCase: The use case for getting the current page of a storyline.
    init(createPomodoroTimerUseCase: CreatePomodoroTimerUseCase, getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase) {
        self.createPomodoroTimerUseCase = createPomodoroTimerUseCase
        self.getCurrentStorylinePageUseCase = getCurrentStorylinePageUseCase
    }
    
    /// Starts a storyline.
    /// - Parameters:
    ///   - storyline: The storyline to start.
    ///   - delegate: The delegate for the Pomodoro timer.
    /// - Returns: A tuple containing the current page of the storyline and the Pomodoro timer.
    func execute(_ storyline: Storyline, delegate: PomodoroTimerDelegate? = nil) throws -> (StorylinePage, PomodoroTimer) {
        let timer = createPomodoroTimerUseCase.execute(duration: storyline.phase == .break ? storyline.breakInterval : storyline.studyInterval)
        timer.delegate = delegate
        
        let page = try getCurrentStorylinePageUseCase.execute(storyline)
        
        return (page, timer)
    }
}
