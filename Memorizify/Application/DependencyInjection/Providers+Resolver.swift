//
//  Providers+Resolver.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import Resolver

public extension Resolver {
    static func registerProviders() {
        
        register { BasicUserDefaultsProvider() as UserDefaultsProvider }
        
        register { BasicKeychainProvider() as KeychainProvider }
    }
}

