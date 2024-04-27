//
//  RemoveGuildMemberUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Represents a use case for removing a member from a guild.
protocol RemoveGuildMemberUseCase {
    
    /// Removes a member from the specified guild.
    /// - Parameters:
    ///   - userUid: The UID of the user to remove.
    ///   - guild: The guild from which to remove the member.
    func execute(userUid: String, from guild: Guild) async throws
}

/// Represents the implementation of the RemoveGuildMemberUseCase protocol.
struct RemoveGuildMemberUseCaseImpl: RemoveGuildMemberUseCase {
    
    private let membersRepository: MembersRepository
    
    /// Initializes the RemoveGuildMemberUseCase implementation with the specified members repository.
    /// - Parameter membersRepository: The repository for managing guild members.
    init(membersRepository: MembersRepository) {
        self.membersRepository = membersRepository
    }
    
    /// Removes a member from the specified guild.
    /// - Parameters:
    ///   - userUid: The UID of the user to remove.
    ///   - guild: The guild from which to remove the member.
    func execute(userUid: String, from guild: Guild) async throws {
        try await membersRepository.remove(with: userUid, from: guild)
    }
}
