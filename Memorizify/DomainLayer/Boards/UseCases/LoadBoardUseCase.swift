//
//  LoadBoardUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

/// Use case protocol for loading the leaderboard.
protocol LoadBoardUseCase {
    
    /// Executes the use case to load the leaderboard.
    /// - Returns: The loaded leaderboard.
    func execute() async throws -> Board
}

/// Implementation of the load board use case.
struct LoadBoardUseCaseImpl: LoadBoardUseCase {
    
    private let boardsRepository: BoardsRepository
    
    /// Initializes the load board use case.
    /// - Parameter boardsRepository: The repository for accessing board-related data.
    init(boardsRepository: BoardsRepository) {
        self.boardsRepository = boardsRepository
    }
    
    /// Executes the use case to load the leaderboard.
    /// - Returns: The loaded leaderboard.
    func execute() async throws -> Board {
        try await boardsRepository.getBoard()
    }
}
