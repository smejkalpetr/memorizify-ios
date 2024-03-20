//
//  UserDefaultsError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

enum UserDefaultsError: Error {
    case valueForKeyNotFound
    case valueTypeError
    case failedToAdd
    case failedToRemove
}
