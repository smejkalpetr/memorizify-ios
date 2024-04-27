//
//  KeychainKeys.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

/// Keys used for storing data in the keychain.
enum KeychainKey: String, CaseIterable {
    case hasUserSeenOnboarding // Indicates whether the user has seen the onboarding screen.
    
    // Don't remove these cases; they are used in XCTests
    case exampleKey
    case nonexistentKey
    case anotherKey
}
