//
//  OnboardingRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

/// Implementation of the OnboardingRepository protocol.
struct OnboardingRepositoryImpl: OnboardingRepository {
    
    private let keychainProvider: KeychainProvider
    
    /// Initializes a new instance of OnboardingRepositoryImpl.
    /// - Parameter keychainProvider: The provider for accessing the keychain.
    init(keychainProvider: KeychainProvider) {
        self.keychainProvider = keychainProvider
    }
    
    /// Saves the information that the user has seen the onboarding.
    func saveHasUserSeenOnboarding() throws {
        try keychainProvider.add(.hasUserSeenOnboarding, value: "true")
    }
    
    /// Loads the information about whether the user has seen the onboarding.
    /// - Returns: A string indicating whether the user has seen the onboarding.
    func loadHasUserSeenOnboarding() throws -> String {
        return try keychainProvider.read(.hasUserSeenOnboarding)
    }
}
