//
//  AcceptGuildInvitationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

protocol AcceptGuildInvitationUseCase {
    func execute(_ invitation: Invitation) async throws
}

struct AcceptGuildInvitationUseCaseImpl: AcceptGuildInvitationUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    func execute(_ invitation: Invitation) async throws {
        try await invitationsRepository.accept(invitation)
    }
}
