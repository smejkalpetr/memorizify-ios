//
//  UserDefaultsKey.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import Foundation

enum UserDefaultsKey: String, CaseIterable {
    case testKey
    
    
    // Don't remove those cases; they are used in XCTests
    case exampleKey
    case nonexistentKey
    case anotherKey
}
