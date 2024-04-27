//
//  CheckHasUserSeenOnboardingUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

/// Checks whether the user has seen the onboarding screens.
protocol CheckHasUserSeenOnboardingUseCase {
    
    /// Executes the check for whether the user has seen the onboarding screens.
    /// - Returns: Returns true if the user has seen the onboarding screens, otherwise false.
    func execute() -> Bool
}

/// Implementation of the CheckHasUserSeenOnboardingUseCase protocol.
struct CheckHasUserSeenOnboardingUseCaseImpl: CheckHasUserSeenOnboardingUseCase {
    
    private let onboardingRepository: OnboardingRepository
    
    /// Initializes the CheckHasUserSeenOnboardingUseCaseImpl instance.
    /// - Parameter onboardingRepository: The repository for accessing onboarding data.
    init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    /// Executes the check for whether the user has seen the onboarding screens.
    /// - Returns: Returns true if the user has seen the onboarding screens, otherwise false.
    func execute() -> Bool {
        let hasSeenOnboarding = try? onboardingRepository.loadHasUserSeenOnboarding()
        return hasSeenOnboarding != nil
    }
}
