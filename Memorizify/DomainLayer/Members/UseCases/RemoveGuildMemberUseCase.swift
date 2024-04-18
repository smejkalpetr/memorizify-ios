//
//  RemoveGuildMemberUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

protocol RemoveGuildMemberUseCase {
    func execute(userUid: String, from guild: Guild) async throws
}

struct RemoveGuildMemberUseCaseImpl: RemoveGuildMemberUseCase {
    
    private let membersRepository: MembersRepository
    
    init(membersRepository: MembersRepository) {
        self.membersRepository = membersRepository
    }
    
    func execute(userUid: String, from guild: Guild) async throws {
        try await membersRepository.remove(with: userUid, from: guild)
    }
}
