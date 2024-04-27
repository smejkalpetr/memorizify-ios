//
//  SaveHasUserSeenOnboardingUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

/// Saves the information that the user has seen the onboarding screens.
protocol SaveHasUserSeenOnboardingUseCase {
    
    /// Executes the saving of the information that the user has seen the onboarding screens.
    func execute() throws
}

/// Implementation of the SaveHasUserSeenOnboardingUseCase protocol.
struct SaveHasUserSeenOnboardingUseCaseImpl: SaveHasUserSeenOnboardingUseCase {
    
    private let onboardingRepository: OnboardingRepository
    
    /// Initializes the SaveHasUserSeenOnboardingUseCaseImpl instance.
    /// - Parameter onboardingRepository: The repository for accessing onboarding data.
    init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    /// Executes the saving of the information that the user has seen the onboarding screens.
    func execute() throws {
        try? onboardingRepository.saveHasUserSeenOnboarding()
    }
}
