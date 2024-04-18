//
//  IncreaseMemberScoreUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

protocol IncreaseMemberScoreUseCase {
    func execute(score: Double, guild: Guild) async throws
}

struct IncreaseMemberScoreUseCaseImpl: IncreaseMemberScoreUseCase {
    
    private let membersRepository: MembersRepository
    
    init(membersRepository: MembersRepository) {
        self.membersRepository = membersRepository
    }
    
    func execute(score: Double, guild: Guild) async throws {
        try await membersRepository.updateScore(to: score, in: guild)
    }
}
