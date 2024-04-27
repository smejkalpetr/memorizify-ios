//
//  LoadMyInvitationsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Handles the loading of invitations for the current user.
protocol LoadMyInvitationsUseCase {
    
    /// Loads invitations for the current user.
    /// - Returns: An array of invitations.
    func execute() async throws -> [Invitation]
}

/// Default implementation of `LoadMyInvitationsUseCase`.
struct LoadMyInvitationsUseCaseImpl: LoadMyInvitationsUseCase {
    
    private let invitationsRepository: InvitationsRepository
    
    /// Initializes the use case with the specified invitations repository.
    /// - Parameter invitationsRepository: The repository handling invitations.
    init(invitationsRepository: InvitationsRepository) {
        self.invitationsRepository = invitationsRepository
    }
    
    /// Loads invitations for the current user.
    /// - Returns: An array of invitations.
    func execute() async throws -> [Invitation] {
        return try await invitationsRepository.getMyInvitations()
    }
}
