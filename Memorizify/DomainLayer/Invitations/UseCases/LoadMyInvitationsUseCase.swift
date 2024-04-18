//
//  LoadMyInvitationsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

protocol LoadMyInvitationsUseCase {
    func execute() async throws -> [Invitation]
}

struct LoadMyInvitationsUseCaseImpl: LoadMyInvitationsUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    func execute() async throws -> [Invitation] {
        return try await invitationsRepository.getMyInvitations()
    }
}
