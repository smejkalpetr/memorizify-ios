//
//  UserDefaultsKey.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import Foundation

/// Enum defining keys used for accessing values stored in UserDefaults.
enum UserDefaultsKey: String, CaseIterable {
    // Key indicating whether the app has run before. This is important
    // to be able to clear Keychian after app delete and install (see AppDelegate).
    case hasEverRunBefore
    
    
    // Don't remove those cases; they are used in XCTests
    case exampleKey
    case nonexistentKey
    case anotherKey
}
