//
//  LoadGlobalBoardUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

protocol LoadGlobalBoardUseCase {
    func execute() async throws -> Board
}

struct LoadGlobalBoardUseCaseImpl: LoadGlobalBoardUseCase {
    
    private let boardsRepository: BoardsRepository
    
    init(boardsRepository: BoardsRepository) {
        self.boardsRepository = boardsRepository
    }
    
    func execute() async throws -> Board {
        try await boardsRepository.getGlobalBoard()
    }
}
