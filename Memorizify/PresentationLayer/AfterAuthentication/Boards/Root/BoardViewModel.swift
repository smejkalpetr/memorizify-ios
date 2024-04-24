//
//  BoardsViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import SwiftUI
import Resolver

final class BoardViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var loadBoardUseCase: LoadBoardUseCase
    
    struct State {
        var alert: AlertData?
        var isBoardLoading = false
        var isInErrorState = false
        var bottomSheetItem: Board?

        var board: Board?
    }
    
    @MainActor
    func loadBoard() {
        Task {
            defer { state.isBoardLoading = false }
            state.isBoardLoading = true
            
            do {
                state.board = try await loadBoardUseCase.execute()
                state.board?.sortByScoreDescending()
                state.isInErrorState = false
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.isInErrorState = true
                state.alert = AlertData(
                    title: "Loading Board Failed",
                    message: "An error occured when loading the board. Please try again."
                )
            }
        }
    }

    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
