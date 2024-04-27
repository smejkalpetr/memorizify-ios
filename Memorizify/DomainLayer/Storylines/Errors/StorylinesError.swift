//
//  StorylinesError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

/// Errors related to storylines.
enum StorylinesError: Error {
    case userNotFound                       // Indicates that the user was not found.
    case pageNotFound                       // Indicates that the page was not found.
    case failedToInitializeFromRawValue     // Indicates that a Storyline couldn't be intialized from raw value.
}
