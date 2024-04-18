//
//  DeleteGuildUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

protocol DeleteGuildUseCase {
    func execute(_ guild: Guild) async throws
}

struct DeleteGuildUseCaseImpl: DeleteGuildUseCase {
    
    private let guildsRepository: GuildsRepository
    private let removeGuildForCurrentUserUseCase: RemoveGuildForCurrentUserUseCase
    private let deleteAllInvitationsForGuildUseCase: DeleteAllInvitationsForGuildUseCase
    
    init(
        guildsRepository: GuildsRepository,
        removeGuildForCurrentUserUseCase: RemoveGuildForCurrentUserUseCase,
        deleteAllInvitationsForGuildUseCase: DeleteAllInvitationsForGuildUseCase
    ) {
        self.guildsRepository = guildsRepository
        self.removeGuildForCurrentUserUseCase = removeGuildForCurrentUserUseCase
        self.deleteAllInvitationsForGuildUseCase = deleteAllInvitationsForGuildUseCase
    }
    
    func execute(_ guild: Guild) async throws {
        try await guildsRepository.delete(guild)
        try await removeGuildForCurrentUserUseCase.execute(guild: guild)
        try await deleteAllInvitationsForGuildUseCase.execute(guild: guild)
    }
}
