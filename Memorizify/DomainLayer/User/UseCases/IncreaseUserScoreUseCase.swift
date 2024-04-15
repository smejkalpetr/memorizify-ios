//
//  IncreaseUserScoreUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

protocol IncreaseUserScoreUseCase {
    func execute(by score: Double) async throws
}

struct IncreaseUserScoreUseCaseImpl: IncreaseUserScoreUseCase {
    
    private let userRepository: UserRepository
    private let getCurretUserUseCase: GetCurrentUserUseCase
    
    init(userRepository: UserRepository, getCurretUserUseCase: GetCurrentUserUseCase) {
        self.userRepository = userRepository
        self.getCurretUserUseCase = getCurretUserUseCase
    }
    
    func execute(by score: Double) async throws {
        let user = try await getCurretUserUseCase.execute()
        try await userRepository.update(user: User(copy: user, score: user.score + score))
    }
}
