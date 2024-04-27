//
//  BoardsRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

/// Protocol for accessing leaderboard-related data.
protocol BoardsRepository {
    
    /// Retrieves the current leaderboard.
    /// - Returns: The current leaderboard.
    func getBoard() async throws -> Board
}
