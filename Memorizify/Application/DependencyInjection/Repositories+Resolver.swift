//
//  Repositories+Resolver.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Resolver

public extension Resolver {
    static func registerRepositories() {
        
        register { AuthenticationRepositoryImpl() as AuthenticationRepository }
    }
}
