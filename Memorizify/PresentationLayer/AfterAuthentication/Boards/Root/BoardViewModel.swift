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
        var hasInitialyLoadedBoard = false
        var alert: AlertData?
        var bottomSheetItem: Board?
        var isBoardLoading = false
        var board: Board?
    }
    
    @MainActor
    func loadBoard() async {
        defer { state.isBoardLoading = false }
        state.isBoardLoading = true
        
        do {
            state.board = try await loadBoardUseCase.execute()
            state.board?.sortByScoreDescending()
        } catch {
            print("Error: \(error)")
            state.alert = AlertData(
                title: "Error loading global board",
                message: "An error occured when loading the global board. Please try again later."
            )
        }
    }

    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
