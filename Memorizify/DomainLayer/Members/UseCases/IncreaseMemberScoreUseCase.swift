//
//  IncreaseMemberScoreUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

/// Represents a use case for increasing a member's score within a guild.
protocol IncreaseMemberScoreUseCase {
    
    /// Increases a member's score within the specified guild.
    /// - Parameters:
    ///   - score: The amount by which to increase the member's score.
    ///   - guild: The guild to which the member belongs.
    func execute(score: Double, guild: Guild) async throws
}

/// Represents the implementation of the IncreaseMemberScoreUseCase protocol.
struct IncreaseMemberScoreUseCaseImpl: IncreaseMemberScoreUseCase {
    
    private let membersRepository: MembersRepository
    
    /// Initializes the IncreaseMemberScoreUseCase implementation with the specified members repository.
    /// - Parameter membersRepository: The repository for managing guild members.
    init(membersRepository: MembersRepository) {
        self.membersRepository = membersRepository
    }
    
    /// Increases a member's score within the specified guild.
    /// - Parameters:
    ///   - score: The amount by which to increase the member's score.
    ///   - guild: The guild to which the member belongs.
    func execute(score: Double, guild: Guild) async throws {
        try await membersRepository.updateScore(to: score, in: guild)
    }
}
