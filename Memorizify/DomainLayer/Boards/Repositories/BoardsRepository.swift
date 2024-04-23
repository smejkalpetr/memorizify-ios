//
//  BoardsRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

protocol BoardsRepository {
    func getBoard() async throws -> Board
}
