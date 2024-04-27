//
//  FirebaseUserError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

/// Errors related to Firebase user operations.
enum FirebaseUserError: Error {
    case notFound           // Indicates that the user was not found.
    case emailNotVerified   // Indicates that the user's email is not verified.
    case emailMissing       // Indicates that the user's email was not found.
    case alreadyVerified    // Indicates that the user's email is already verified.
}
