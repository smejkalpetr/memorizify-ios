//
//  BoardDetailViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import SwiftUI

final class BoardDetailViewModel: ObservableObject {
    
    @Published var state: State
    
    struct State {
        var board: Board
        
        init(board: Board) {
            self.board = board
            self.board.sortByScoreDescending()
        }
    }
    
    init(board: Board) {
        self.state = State(board: board)
    }
    
    @MainActor
    func changeUsernameSorting() {
        switch state.board.sorted {
        case .usernameAscending:
            state.board.sortByUsernameDescending()
        case .usernameDescending:
            state.board.sortByUsernameAscending()
        default:
            state.board.sortByUsernameAscending()
        }
    }
    
    @MainActor
    func changeScoreSorting() {
        switch state.board.sorted {
        case .scoreAscending:
            state.board.sortByScoreDescending()
        case .scoreDescending:
            state.board.sortByScoreAscending()
        default:
            state.board.sortByScoreDescending()
        }
    }
}
