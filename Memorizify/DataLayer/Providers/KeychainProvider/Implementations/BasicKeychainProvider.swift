//
//  BasicKeychainProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import Foundation
import KeychainAccess

struct BasicKeychainProvider: KeychainProvider {
    
    init() {}
    
    func add(_ key: KeychainKey, value: String) throws {
        guard let bundleId = Bundle.main.bundleIdentifier else { throw KeychainError.bundleIdNotFound }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        keychain[key.rawValue] = value
    }
    
    func read(_ key: KeychainKey) throws -> String {
        guard let bundleId = Bundle.main.bundleIdentifier else { throw KeychainError.bundleIdNotFound }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        guard let value = keychain[key.rawValue] else { throw KeychainError.valueForKeyNotFound }
        return value
    }
    
    func remove(_ key: KeychainKey) throws {
        guard let bundleId = Bundle.main.bundleIdentifier else { throw KeychainError.bundleIdNotFound }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        try keychain.remove(key.rawValue)
    }
    
    func removeAll() throws {
        for key in KeychainKey.allCases {
            try remove(key)
        }
    }
    
    func removeAll(except values: [KeychainKey]) throws {
        for key in KeychainKey.allCases where !values.contains(key) {
            try remove(key)
        }
    }
}
