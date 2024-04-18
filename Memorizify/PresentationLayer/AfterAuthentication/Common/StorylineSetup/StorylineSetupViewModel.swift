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
    static let goalHoursRange = 0...300.0
    static let studyIntervalRange = 0...120.0
    static let breakIntervalRange = 0...30.0
    
    enum Setup {
        case create(StorylineKind)
        case update(Storyline)
    }
    
    private let setup: Setup
    
    @Published var state: State
    
    @Injected private var saveStorylineUseCase: SaveStorylineUseCase
    
    init(setup: Setup, shouldHomeUpdate: Binding<Bool>? = nil) {
        self.setup = setup
        self.state = State(setup: setup)
    }

    struct State {
        var alert: AlertData?
        var isButtonLoading = false
        
        var goalMinutes = (goalMinutesRange.lowerBound + goalMinutesRange.upperBound) / 2
        var goalHours = (goalHoursRange.lowerBound + goalHoursRange.upperBound) / 2
        var studyInterval = (studyIntervalRange.lowerBound + studyIntervalRange.upperBound) / 2
        var breakInterval = (breakIntervalRange.lowerBound + breakIntervalRange.upperBound) / 2
        
        init(setup: Setup) {
            switch setup {
            case .create:
                self.goalMinutes = (goalMinutesRange.lowerBound + goalMinutesRange.upperBound) / 2
                self.goalHours = (goalHoursRange.lowerBound + goalHoursRange.upperBound) / 2
                self.studyInterval = (studyIntervalRange.lowerBound + studyIntervalRange.upperBound) / 2
                self.breakInterval = (breakIntervalRange.lowerBound + breakIntervalRange.upperBound) / 2
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
            } catch {
                state.alert = AlertData(title: "Error setting up storyline!")
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
