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
        var isInErrorState = false
        var isStorylinesLoading = false
        var hasInitialyLoadedStorylines = false
        var isPlainTimerBottomSheetPresented = false
        var storylines: [Storyline] = []
    }
    
    @MainActor
    func loadAllStorylines() async {
        defer { state.isStorylinesLoading = false }
        state.isStorylinesLoading = true
        clearErrors()
        
        do {
            let storylines = try await loadAllStorylinesUseCase.execute()
            state.storylines = storylines ?? []
        } catch {
            #warning("TODO: Error handling not finished!")
            print("Error loading storylines: \(error)")
            state.isInErrorState = true
        }
    }
    
    @MainActor
    func clearErrors() {
        state.isInErrorState = false
    }
}
