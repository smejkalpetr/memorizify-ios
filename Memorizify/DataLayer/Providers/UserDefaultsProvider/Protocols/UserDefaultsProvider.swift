//
//  UserDefaultsProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

/// Protocol for interacting with UserDefaults.
protocol UserDefaultsProvider {
    
    /// Add a value to UserDefaults with the specified key.
    /// - Parameters:
    ///   - key: The key under which to store the value.
    ///   - value: The value to store.
    func add(_ key: UserDefaultsKey, value: String) throws
    
    /// Read a value from UserDefaults using the specified key.
    /// - Parameter key: The key associated with the value to read.
    /// - Returns: The value associated with the key.
    func read(_ key: UserDefaultsKey) throws -> String
    
    /// Remove the value associated with the specified key from UserDefaults.
    /// - Parameter key: The key whose associated value should be removed.
    func remove(_ key: UserDefaultsKey) throws
    
    /// Remove all values stored in UserDefaults.
    func removeAll() throws
}
