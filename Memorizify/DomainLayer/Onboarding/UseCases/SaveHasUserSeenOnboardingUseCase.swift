//
//  SaveHasUserSeenOnboardingUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

protocol SaveHasUserSeenOnboardingUseCase {
    func execute() throws
}

struct SaveHasUserSeenOnboardingUseCaseImpl: SaveHasUserSeenOnboardingUseCase {
    
    private let onboardingRepository: OnboardingRepository
    
    init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    func execute() throws {
        try? onboardingRepository.saveHasUserSeenOnboarding()
    }
}
