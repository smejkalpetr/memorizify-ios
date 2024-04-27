//
//  OnboardingRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

/// Handles the data related to the onboarding process.
protocol OnboardingRepository {
    
    /// Saves the information that the user has seen the onboarding screens.
    func saveHasUserSeenOnboarding() throws
    
    /// Loads the information about whether the user has seen the onboarding screens.
    /// - Returns: Returns a string indicating whether the user has seen the onboarding screens.
    func loadHasUserSeenOnboarding() throws -> String
}
