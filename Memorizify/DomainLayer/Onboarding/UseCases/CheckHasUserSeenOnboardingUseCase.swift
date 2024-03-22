//
//  CheckHasUserSeenOnboardingUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

protocol CheckHasUserSeenOnboardingUseCase {
    func execute() -> Bool
}

struct CheckHasUserSeenOnboardingUseCaseImpl: CheckHasUserSeenOnboardingUseCase {
    
    private let onboardingRepository: OnboardingRepository
    
    init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    func execute() -> Bool {
        let hasSeenOnboarding = try? onboardingRepository.loadHasUserSeenOnboarding()
        return hasSeenOnboarding != nil
    }
}
