//
//  KeychainProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

// NOTE: This data structure has been taken from a publicly available
//       project called "Devstack Native App" by "MateeDevs".
//       The project is available at: https://github.com/MateeDevs/devstack-native-app

/// Protocol for interacting with the keychain.
protocol KeychainProvider {
    
    /// Adds a value to the keychain with the specified key.
    /// - Parameters:
    ///   - key: The key to associate with the value.
    ///   - value: The value to store in the keychain.
    func add(_ key: KeychainKey, value: String) throws
    
    /// Reads the value associated with the specified key from the keychain.
    /// - Parameter key: The key whose associated value is to be read.
    /// - Returns: The value associated with the specified key.
    func read(_ key: KeychainKey) throws -> String
    
    /// Removes the value associated with the specified key from the keychain.
    /// - Parameter key: The key whose associated value is to be removed.
    func remove(_ key: KeychainKey) throws
    
    /// Removes all values from the keychain.
    func removeAll() throws
    
    /// Removes all values from the keychain except those specified.
    /// - Parameter values: The keys whose associated values should not be removed.
    func removeAll(except values: [KeychainKey]) throws
}
