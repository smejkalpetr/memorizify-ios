//
//  AcceptGuildInvitationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Handles the acceptance of guild invitations.
protocol AcceptGuildInvitationUseCase {
    
    /// Accepts a guild invitation.
    /// - Parameter invitation: The invitation to accept.
    func execute(_ invitation: Invitation) async throws
}

/// Default implementation of `AcceptGuildInvitationUseCase`.
struct AcceptGuildInvitationUseCaseImpl: AcceptGuildInvitationUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    /// Initializes the use case with the specified invitations repository.
    /// - Parameter invitationsRepository: The repository handling invitations.
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    /// Accepts a guild invitation.
    /// - Parameter invitation: The invitation to accept.
    func execute(_ invitation: Invitation) async throws {
        try await invitationsRepository.accept(invitation)
    }
}
