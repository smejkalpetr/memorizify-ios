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
        
        register { UserRepositoryImpl(authenticationRepository: resolve()) as UserRepository }
        
        register { StorylinesRepositoryImpl(authenticationRepository: resolve()) as StorylinesRepository }
        
        register { BoardsRepositoryImpl(authenticationRepository: resolve()) as BoardsRepository }
        
        register { 
            GuildsRepositoryImpl(
                authenticationRepository: resolve(),
                userRepository: resolve()
            ) as GuildsRepository }
        
        register {
            InvitationsRepositoryImpl(
                authenticationRepository: resolve(),
                userRepository: resolve(),
                guildsRepository: resolve()
            ) as InvitationsRepository
        }
        
        register { MembersRepositoryImpl(guildsRepository: resolve(), userRepository: resolve()) as MembersRepository }
    }
}
