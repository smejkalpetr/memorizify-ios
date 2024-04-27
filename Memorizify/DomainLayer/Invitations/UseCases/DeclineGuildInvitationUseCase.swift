//
//  DeclineGuildInvitationUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Handles the declining of guild invitations.
protocol DeclineGuildInvitationUseCase {
    
    /// Declines a guild invitation.
    /// - Parameter invitation: The invitation to decline.
    func execute(_ invitation: Invitation) async throws
}

/// Default implementation of `DeclineGuildInvitationUseCase`.
struct DeclineGuildInvitationUseCaseImpl: DeclineGuildInvitationUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    /// Initializes the use case with the specified invitations repository.
    /// - Parameter invitationsRepository: The repository handling invitations.
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    /// Declines a guild invitation.
    /// - Parameter invitation: The invitation to decline.
    func execute(_ invitation: Invitation) async throws {
        try await invitationsRepository.decline(invitation)
    }
}
