//
//  GlobalBoardDetailViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import SwiftUI

final class GlobalBoardDetailViewModel: ObservableObject {
    
    @Published var state: State
    
    struct State {
        var globalBoard: Board
        
        init(globalBoard: Board) {
            self.globalBoard = globalBoard
            self.globalBoard.sortByScoreDescending()
        }
    }
    
    init(globalBoard: Board) {
        self.state = State(globalBoard: globalBoard)
    }
    
    @MainActor
    func changeNicknameSorting() {
        switch state.globalBoard.sorted {
        case .nicknameAscending:
            state.globalBoard.sortByNicknameDescending()
        case .nicknameDescending:
            state.globalBoard.sortByNicknameAscending()
        default:
            state.globalBoard.sortByNicknameAscending()
        }
    }
    
    @MainActor
    func changeScoreSorting() {
        switch state.globalBoard.sorted {
        case .scoreAscending:
            state.globalBoard.sortByScoreDescending()
        case .scoreDescending:
            state.globalBoard.sortByScoreAscending()
        default:
            state.globalBoard.sortByScoreDescending()
        }
    }
}
