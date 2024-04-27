//
//  KeychainError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

/// Errors that may occur while interacting with the keychain.
enum KeychainError: Error {
    case valueForKeyNotFound    // The value for the specified key was not found.
    case bundleIdNotFound       // The bundle ID was not found.
}
