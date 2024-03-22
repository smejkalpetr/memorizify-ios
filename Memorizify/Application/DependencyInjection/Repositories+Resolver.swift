//
//  Repositories+Resolver.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Resolver

public extension Resolver {
    static func registerRepositories() {
        
        register { OnboardingRepositoryImpl(keychainProvider: resolve()) as OnboardingRepository }
        
        register { AuthenticationRepositoryImpl() as AuthenticationRepository }
    }
}
