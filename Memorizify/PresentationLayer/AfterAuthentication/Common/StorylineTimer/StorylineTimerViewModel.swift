//
//  StorylineTimerViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import SwiftUI
import Resolver
import Foundation

final class StorylineTimerViewModel: ObservableObject, PomodoroTimerDelegate {
    
    private let timer: PomodoroTimer
        
    @Published var state: State
    
    @Injected private var setPomodoroTimerDelegateUseCase: SetPomodoroTimerDelegateUseCase
    @Injected private var formatSecondsToStringUseCase: FormatSecondsToStringUseCase
    @Injected private var saveStorylineUseCase: SaveStorylineUseCase
    @Injected private var getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase
    @Injected private var increaseUserScoreUseCase: IncreaseUserScoreUseCase
    @Injected private var increaseMemberScoreUseCase: IncreaseMemberScoreUseCase
    
    struct State {
        var alert: AlertData?
        var isLoading = false
        var isDone = false
        var isPaused = false
        var countdown = ""
        var transition: LocalizedStringResource?
        
        var timerKind: PomodoroTimerKind
        var storyline: Storyline
        var page: StorylinePage
        
        init(storyline: Storyline, page: StorylinePage, timerKind: PomodoroTimerKind) {
            self.storyline = storyline
            self.page = page
            self.timerKind = timerKind
        }
    }
    
    init(storyline: Storyline, page: StorylinePage, timer: PomodoroTimer, timerKind: PomodoroTimerKind) {
        self.timer = timer
        self.state = State(storyline: storyline, page: page, timerKind: timerKind)
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
        switch state.timerKind {
        case .plain:
            state.page = PlainTimerStorylinePage()
        default:
            state.page = (try? getCurrentStorylinePageUseCase.execute(state.storyline)) ?? state.page
        }
        
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
        do {
            state.countdown = try formatSecondsToStringUseCase.execute(seconds: status.timeRemaining)
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func didFinish() {
        switch state.timerKind {
        case .storyline:
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
        case .guild:
            guard let _ = state.storyline.guild else { return }
            
            Task {
                await saveGuildScore()
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
        case .plain:
            Task {
                await savePlainTimerScore()
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
                refreshStorylines()
            }
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Saving Storyline Failed",
                message: "An error occured when saving storyline data."
            )
        }
    }
    
    @MainActor
    private func saveGuildScore() async {
        defer { state.isLoading = false }
        state.isLoading = true
        
        do {
            if state.storyline.phase == .study {
                guard let guild = state.storyline.guild else { throw GuildsError.failedToSaveScore }
                let score = floor(timer.timeElapsed / 60.0)
                try await increaseMemberScoreUseCase.execute(score: score, guild: guild)
                try await increaseUserScoreUseCase.execute(by: score)
                refreshGuildDetail()
            }
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Saving Guild Score Failed",
                message: "An error occured when saving guild score data."
            )
        }
    }
    
    @MainActor
    private func savePlainTimerScore() async {
        defer { state.isLoading = false }
        state.isLoading = true
        
        do {
            if state.storyline.phase == .study {
                let finished = floor(timer.timeElapsed / 60.0)
                try await increaseUserScoreUseCase.execute(by: finished)
            }
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Saving Score Failed",
                message: "An error occured when saving score data."
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
    
    private func refreshGuildDetail() {
        NotificationCenter.default.post(name: .refreshGuildDetail, object: nil)
    }
    
    func refreshStorylines() {
        NotificationCenter.default.post(name: .refreshStorylines, object: nil)
    }
}
