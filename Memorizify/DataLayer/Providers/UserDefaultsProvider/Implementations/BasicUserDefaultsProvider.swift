//
//  BasicUserDefaultsProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import Foundation

struct BasicUserDefaultsProvider: UserDefaultsProvider {
    
    private let defaults = UserDefaults.standard
    
    init() {}
    
    func add(_ key: UserDefaultsKey, value: String) throws {
        defaults.set(value, forKey: key.rawValue)
        
        // Check if key actually added
        guard let _ = try? read(key) else { throw UserDefaultsError.failedToAdd }
    }
    
    func read(_ key: UserDefaultsKey) throws -> String {
        guard let rawValue = defaults.value(forKey: key.rawValue) else { throw UserDefaultsError.valueForKeyNotFound }
        guard let value = rawValue as? String else { throw UserDefaultsError.valueTypeError }
        return value
    }
    
    func remove(_ key: UserDefaultsKey) throws {
        defaults.removeObject(forKey: key.rawValue)
        
        // Check if key actually removed
        let value = try? read(key)
        guard value == nil else { throw UserDefaultsError.failedToRemove }
    }
    
    func removeAll() throws {
        for key in UserDefaultsKey.allCases {
            try remove(key)
        }
    }
}
