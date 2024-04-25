//
//  StorylineSetupViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

import SwiftUI
import Resolver
import Foundation

final class StorylineSetupViewModel: ObservableObject {
    
    static let goalMinutesRange = 0...60.0
    static let goalHoursRange = 10...100.0
    static let studyIntervalRange = 5...60.0
    static let breakIntervalRange = 1...15.0
    
    enum Setup {
        case create(StorylineKind)
        case update(Storyline)
    }
    
    private let setup: Setup
    private let detailCompletion: (() -> ())?
    
    @Published var state: State
    
    @Injected private var saveStorylineUseCase: SaveStorylineUseCase
    
    init(setup: Setup, detailCompletion: (() -> ())? = nil) {
        self.setup = setup
        self.state = State(setup: setup)
        self.detailCompletion = detailCompletion
    }

    struct State {
        var alert: AlertData?
        var isButtonLoading = false
        
        var goalMinutes = 0.0
        var goalHours = 50.0
        var studyInterval = 30.0
        var breakInterval = 5.0
        
        init(setup: Setup) {
            switch setup {
            case .create:
                self.goalMinutes = 0.0
                self.goalHours = 50.0
                self.studyInterval = 30.0
                self.breakInterval = 5.0
            case let .update(storyline):
                self.goalMinutes = storyline.goalMinutes
                self.goalHours = storyline.goalHours
                self.studyInterval = storyline.studyInterval
                self.breakInterval = storyline.breakInterval
            }
        }
    }
    
    @MainActor
    func setupStoryline(completion: @escaping () -> ()) {
        Task {
            defer { state.isButtonLoading = false }
            state.isButtonLoading = true
            
            do {
                switch setup {
                case let .create(kind):
                    let storyline = Storyline(
                        kind: kind,
                        goalHours: state.goalHours,
                        goalMinutes: state.goalMinutes,
                        finished: 0.0,
                        studyInterval: state.studyInterval,
                        breakInterval: state.breakInterval
                    )
                    
                    try await saveStorylineUseCase.execute(storyline)
                case let .update(originalStoryline):
                    let storyline = Storyline(
                        copy: originalStoryline,
                        goalHours: state.goalHours,
                        goalMinutes: state.goalMinutes,
                        studyInterval: state.studyInterval,
                        breakInterval: state.breakInterval
                    )
                    
                    try await saveStorylineUseCase.execute(storyline)
                }
                
                refreshStorylinesOnHomeTab()
                completion()
                detailCompletion?()
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Storyline Setup Failed",
                    message: "An error occured when setting up storyline. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    private func refreshStorylinesOnHomeTab() {
        NotificationCenter.default.post(name: .refreshStorylines, object: nil)
    }
}
