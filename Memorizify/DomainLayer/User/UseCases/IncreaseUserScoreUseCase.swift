//
//  IncreaseUserScoreUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

/// Increases the user's score.
protocol IncreaseUserScoreUseCase {
    
    /// Executes the increase of the user's score by the given amount.
    /// - Parameter score: The amount by which to increase the user's score.
    func execute(by score: Double) async throws
}

/// Implementation of the IncreaseUserScoreUseCase protocol.
struct IncreaseUserScoreUseCaseImpl: IncreaseUserScoreUseCase {
    
    private let userRepository: UserRepository
    private let getCurrentUserUseCase: GetCurrentUserUseCase
    
    /// Initializes the IncreaseUserScoreUseCaseImpl instance.
    /// - Parameters:
    ///   - userRepository: The repository for accessing user data.
    ///   - getCurrentUserUseCase: The use case for retrieving the current user.
    init(userRepository: UserRepository, getCurrentUserUseCase: GetCurrentUserUseCase) {
        self.userRepository = userRepository
        self.getCurrentUserUseCase = getCurrentUserUseCase
    }
    
    /// Executes the increase of the user's score by the given amount.
    /// - Parameter score: The amount by which to increase the user's score.
    func execute(by score: Double) async throws {
        let user = try await getCurrentUserUseCase.execute()
        try await userRepository.update(user: User(copy: user, score: user.score + score))
    }
}
