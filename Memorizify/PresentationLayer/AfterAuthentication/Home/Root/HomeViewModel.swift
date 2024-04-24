//
//  HomeViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

import SwiftUI
import Resolver

final class HomeViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var loadAllStorylinesUseCase: LoadAllStorylinesUseCase
    
    struct State {
        var alert: AlertData?
        var isInErrorState = false
        var isStorylinesLoading = false
        var isPlainTimerBottomSheetPresented = false
        var storylines: [Storyline] = []
    }
    
    @MainActor
    func loadAllStorylines() {
        Task {
            defer { state.isStorylinesLoading = false }
            state.isStorylinesLoading = true
            clearErrors()
            
            do {
                let storylines = try await loadAllStorylinesUseCase.execute()
                state.storylines = storylines ?? []
                state.isInErrorState = false
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.isInErrorState = true
            }
        }
    }
    
    @MainActor
    func clearErrors() {
        state.isInErrorState = false
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
