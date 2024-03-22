//
//  OnboardingRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

struct OnboardingRepositoryImpl: OnboardingRepository {
    
    private let keychainProvider: KeychainProvider
    
    init(keychainProvider: KeychainProvider) {
        self.keychainProvider = keychainProvider
    }
    
    func saveHasUserSeenOnboarding() throws {
        try keychainProvider.add(.hasUserSeenOnboarding, value: "true")
    }
    
    func loadHasUserSeenOnboarding() throws -> String {
        return try keychainProvider.read(.hasUserSeenOnboarding)
    }
}
