//
//  ValidateRepeatedPassword.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

/// Validates that the repeated password matches the original password.
protocol ValidateRepeatedPasswordUseCase {
    
    /// Validates the repeated password.
    /// - Parameters:
    ///   - password: The original password.
    ///   - repeatedPassword: The repeated password to compare.
    func execute(password: String, repeatedPassword: String) throws
}

/// Implementation of the ValidateRepeatedPasswordUseCase protocol.
struct ValidateRepeatedPasswordImpl: ValidateRepeatedPasswordUseCase {
    
    /// Initializes the ValidateRepeatedPasswordImpl instance.
    init() {}
    
    /// Validates that the repeated password matches the original password.
    /// - Parameters:
    ///   - password: The original password.
    ///   - repeatedPassword: The repeated password to compare.
    /// - Throws: An error of type `ValidationError.invalidRepeatedPassword` if the repeated password does not match the original password.
    func execute(password: String, repeatedPassword: String) throws {
        guard password == repeatedPassword else { throw ValidationError.invalidRepeatedPassword }
    }
}
