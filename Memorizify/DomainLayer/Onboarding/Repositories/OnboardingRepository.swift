//
//  OnboardingRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

protocol OnboardingRepository {
    func saveHasUserSeenOnboarding() throws
    func loadHasUserSeenOnboarding() throws -> String
}
