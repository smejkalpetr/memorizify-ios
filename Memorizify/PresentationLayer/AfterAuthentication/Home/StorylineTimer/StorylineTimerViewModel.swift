//
//  StorylineTimerViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import SwiftUI
import Resolver

final class StorylineTimerViewModel: ObservableObject, PomodoroTimerDelegate {
    
    private let timer: PomodoroTimer
        
    @Published var state: State
    
    @Injected private var setPomodoroTimerDelegateUseCase: SetPomodoroTimerDelegateUseCase
    @Injected private var formatSecondsToStringUseCase: FormatSecondsToStringUseCase
    @Injected private var saveStorylineUseCase: SaveStorylineUseCase
    @Injected private var getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase
    @Injected private var increaseUserScoreUseCase: IncreaseUserScoreUseCase
    
    struct State {
        var storyline: Storyline
        var page: StorylinePage
        
        var alert: AlertData?
        var isLoading = false
        var isDone = false
        var isPaused = false
        var countdown = ""
        var transition: String?
        
        init(storyline: Storyline, page: StorylinePage) {
            self.storyline = storyline
            self.page = page
        }
    }
    
    init(storyline: Storyline, page: StorylinePage, timer: PomodoroTimer) {
        self.timer = timer
        self.state = State(storyline: storyline, page: page)
    }
    
    func setDelegate() {
        setPomodoroTimerDelegateUseCase.execute(delegate: self, for: timer)
    }
    
    @MainActor
    func start() {
        timer.start()
    }
    
    @MainActor
    func pause() {
        timer.pause()
        state.isPaused = timer.state == .paused
    }
    
    @MainActor
    func resume() {
        timer.start()
        state.isPaused = timer.state == .paused
    }

    @MainActor
    func cancel(completion: (() -> ())? = nil) {
        Task {
            await saveStoryline()
            timer.stop()
            completion?()
        }
    }
    
    @MainActor
    func repeatTimer() {
        state.page = (try? getCurrentStorylinePageUseCase.execute(state.storyline)) ?? state.page
        
        timer.reset(with: state.storyline.studyInterval * 60)
        timer.start()
        
        state.isDone = false
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    // MARK: PomodoroTimerDelegate
    
    func tick(with status: PomodoroTimerStatus) {
        #warning("Thrown error not handled properly")
        state.countdown = (try? formatSecondsToStringUseCase.execute(seconds: status.timeRemaining)) ?? "error"
    }
    
    @MainActor
    func didFinish() {
        Task {
            await saveStoryline()
            timer.stop()
            
            switch state.storyline.phase {
            case .study:
                await startCountdownTransition()
                
                timer.reset(with: state.storyline.breakInterval * 60)
                timer.start()
            case .break:
                state.isDone = true
            }
            
            state.storyline.phase.toggle()
        }
    }
    
    // MARK: Private
    
    @MainActor
    private func saveStoryline() async {
        defer { state.isLoading = false }
        state.isLoading = true
        
        do {
            if state.storyline.phase == .study {
                let finished = floor(timer.timeElapsed / 60.0)
                state.storyline = Storyline(copy: state.storyline, finished: state.storyline.finished + finished)
                try await saveStorylineUseCase.execute(Storyline(copy: state.storyline, finished: state.storyline.finished))
                try await increaseUserScoreUseCase.execute(by: finished)
            }
        } catch {
            state.alert = AlertData(
                title: "Storyline error",
                message: "Failed to save storyline data!"
            )
        }
    }
    
    @MainActor
    private func startCountdownTransition() async {
        var seconds = 3

        while seconds >= 0 {
            self.state.transition = "Break starting in \(seconds)..."
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            seconds -= 1
        }
        
        state.transition = nil
    }
}
