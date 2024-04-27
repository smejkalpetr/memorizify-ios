//
//  BasicUserDefaultsProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import Foundation

/// Provides basic interaction with UserDefaults.
struct BasicUserDefaultsProvider: UserDefaultsProvider {
    
    /// The UserDefaults instance.
    private let defaults = UserDefaults.standard
    
    /// Initializes the provider.
    init() {}
    
    /// Adds a value to UserDefaults with the specified key.
    /// - Parameters:
    ///   - key: The key under which to store the value.
    ///   - value: The value to store.
    func add(_ key: UserDefaultsKey, value: String) throws {
        defaults.set(value, forKey: key.rawValue)
        
        // Check if key actually added
        guard let _ = try? read(key) else { throw UserDefaultsError.failedToAdd }
    }
    
    /// Reads a value from UserDefaults using the specified key.
    /// - Parameter key: The key associated with the value to read.
    /// - Returns: The value associated with the key.
    func read(_ key: UserDefaultsKey) throws -> String {
        guard let rawValue = defaults.value(forKey: key.rawValue) else { throw UserDefaultsError.valueForKeyNotFound }
        guard let value = rawValue as? String else { throw UserDefaultsError.valueTypeError }
        return value
    }
    
    /// Removes the value associated with the specified key from UserDefaults.
    /// - Parameter key: The key whose associated value should be removed.
    func remove(_ key: UserDefaultsKey) throws {
        defaults.removeObject(forKey: key.rawValue)
        
        // Check if key actually removed
        let value = try? read(key)
        guard value == nil else { throw UserDefaultsError.failedToRemove }
    }
    
    /// Removes all values stored in UserDefaults.
    func removeAll() throws {
        for key in UserDefaultsKey.allCases {
            try remove(key)
        }
    }
}
