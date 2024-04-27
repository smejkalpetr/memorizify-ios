//
//  ValidationError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

/// Represents various validation errors that can occur during user input validation.
enum ValidationError: Error {
    case invalidUsername          // Indicates an invalid username error.
    case invalidEmail             // Indicates an invalid email error.
    case invalidPassword          // Indicates an invalid password error.
    case invalidRepeatedPassword  // Indicates an invalid repeated password error.
    case invalidGuildName         // Indicates an invalid guild name error.
}
