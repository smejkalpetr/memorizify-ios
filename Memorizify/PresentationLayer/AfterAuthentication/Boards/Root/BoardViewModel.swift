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
    
    @Injected private var loadGlobalBoardUseCase: LoadGlobalBoardUseCase
    
    struct State {
        var hasInitialyLoadedBoard = false
        var alert: AlertData?
        var bottomSheetItem: Board?
        var isGlobalBoardLoading = false
        var globalBoard: Board?
    }
    
    @MainActor
    func loadGlobalBoard() async {
        defer { state.isGlobalBoardLoading = false }
        state.isGlobalBoardLoading = true
        
        do {
            state.globalBoard = try await loadGlobalBoardUseCase.execute()
            state.globalBoard?.sortByScoreDescending()
        } catch {
            print("Error: \(error)")
            state.alert = AlertData(
                title: "Error loading global board",
                message: "An error occured when loading the global board. Please try again later."
            )
        }
    }
    
    @MainActor
    func changeNicknameSorting() {
        switch state.globalBoard?.sorted {
        case .nicknameAscending:
            state.globalBoard?.sortByNicknameDescending()
        case .nicknameDescending:
            state.globalBoard?.sortByNicknameAscending()
        default:
            state.globalBoard?.sortByNicknameAscending()
        }
    }
    
    @MainActor
    func changeScoreSorting() {
        switch state.globalBoard?.sorted {
        case .scoreAscending:
            state.globalBoard?.sortByScoreDescending()
        case .scoreDescending:
            state.globalBoard?.sortByScoreAscending()
        default:
            state.globalBoard?.sortByScoreDescending()
        }
    }

    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
