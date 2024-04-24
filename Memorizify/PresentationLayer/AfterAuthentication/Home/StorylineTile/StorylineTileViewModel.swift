//
//  StorylineTileViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

import SwiftUI
import Resolver

final class StorylineTileViewModel: ObservableObject {
    
    @Published var state: State
    
    @Injected private var saveStorylineUseCase: SaveStorylineUseCase
    @Injected private var deleteStorylineUseCase: DeleteStorylineUseCase
    @Injected private var startStorylineUseCase: StartStorylineUseCase
    
    struct State {
        var alert: AlertData?
        var bottomSheetItem: Storyline?
        var isLoading = false
        var storyline: Storyline
    }
    
    init(storyline: Storyline) {
        self.state = State(storyline: storyline)
    }
    
    @MainActor
    func delete() {
        state.alert = AlertData(
            title: "Delete Storyline",
            message: "Are you sure you want to delete the storyline?",
            primaryAction: AlertData.Action(
                title: "Cancel",
                style: .cancel
            ),
            secondaryAction: AlertData.Action(
                title: "Delete",
                style: .destruction,
                handler: deleteAction
            )
        )
    }
    
    @MainActor
    func deleteAction() {
        Task {
            defer { state.isLoading = false }
            state.isLoading = true
            
            do {
                try await deleteStorylineUseCase.execute(state.storyline)
                refreshStorylinesOnHomeTab()
            } catch {
                state.alert = AlertData(title: "Deleting storyline failed!", message: "error.localizedDescription")
            }
        }
    }
    
    func start(completion: (Storyline, StorylinePage, PomodoroTimer) -> ()) {
        do {
            let (page, timer) = try startStorylineUseCase.execute(state.storyline)
            completion(state.storyline, page, timer)
        } catch {
            print("error: \(error)")
            state.alert = AlertData(
                title: "Error starting storyline", 
                message: "An error occured when starting the storyline. Please try again!"
            )
        }
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    func refreshStorylinesOnHomeTab() {
        NotificationCenter.default.post(name: .refreshStorylines, object: nil)
    }
}
