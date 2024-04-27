//
//  UserDefaultsError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

/// Enum defining errors related to user defaults operations.
enum UserDefaultsError: Error {
    case valueForKeyNotFound    // The requested value for the specified key was not found.
    case valueTypeError         // The retrieved value has a different type than expected.
    case failedToAdd            // Failed to add a value to user defaults.
    case failedToRemove         // Failed to remove a value from user defaults.
}
