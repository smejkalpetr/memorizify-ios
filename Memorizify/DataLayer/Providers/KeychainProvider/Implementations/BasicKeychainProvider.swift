//
//  BasicKeychainProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import Foundation
import KeychainAccess

// NOTE: This data structure has been taken from a publicly available
//       project called "Devstack Native App" by "MateeDevs".
//       The project is available at: https://github.com/MateeDevs/devstack-native-app

/// Implementation of the KeychainProvider protocol using KeychainAccess library.
struct BasicKeychainProvider: KeychainProvider {
    
    /// Initializes a new instance of BasicKeychainProvider.
    init() {}
    
    /// Adds a value to the keychain with the specified key.
    /// - Parameters:
    ///   - key: The key to associate with the value.
    ///   - value: The value to store in the keychain.
    func add(_ key: KeychainKey, value: String) throws {
        guard let bundleId = Bundle.main.bundleIdentifier else { throw KeychainError.bundleIdNotFound }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        keychain[key.rawValue] = value
    }
    
    /// Reads the value associated with the specified key from the keychain.
    /// - Parameter key: The key whose associated value is to be read.
    /// - Returns: The value associated with the specified key.
    func read(_ key: KeychainKey) throws -> String {
        guard let bundleId = Bundle.main.bundleIdentifier else { throw KeychainError.bundleIdNotFound }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        guard let value = keychain[key.rawValue] else { throw KeychainError.valueForKeyNotFound }
        return value
    }
    
    /// Removes the value associated with the specified key from the keychain.
    /// - Parameter key: The key whose associated value is to be removed.
    func remove(_ key: KeychainKey) throws {
        guard let bundleId = Bundle.main.bundleIdentifier else { throw KeychainError.bundleIdNotFound }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        try keychain.remove(key.rawValue)
    }
    
    /// Removes all values from the keychain.
    func removeAll() throws {
        for key in KeychainKey.allCases {
            try remove(key)
        }
    }
    
    /// Removes all values from the keychain except those specified.
    /// - Parameter values: The keys whose associated values should not be removed.
    func removeAll(except values: [KeychainKey]) throws {
        for key in KeychainKey.allCases where !values.contains(key) {
            try remove(key)
        }
    }
}
