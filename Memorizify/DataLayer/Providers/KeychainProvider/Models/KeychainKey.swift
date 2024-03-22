//
//  KeychainKeys.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

enum KeychainKey: String, CaseIterable {
    case hasUserSeenOnboarding
    
    
    // Don't remove those cases; they are used in XCTests
    case exampleKey
    case nonexistentKey
    case anotherKey
}
