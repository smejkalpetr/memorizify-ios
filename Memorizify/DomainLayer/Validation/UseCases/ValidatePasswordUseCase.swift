//
//  ValidatePasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

/// Validates the password format.
protocol ValidatePasswordUseCase {
    
    /// Validates the provided password.
    /// - Parameter password: The password to validate.
    func execute(password: String) throws
}

/// Implementation of the ValidatePasswordUseCase protocol.
struct ValidatePasswordUseCaseImpl: ValidatePasswordUseCase {
    
    /// Initializes the ValidatePasswordUseCaseImpl instance.
    init() {}
    
    /// Validates the provided password.
    /// - Parameter password: The password to validate.
    /// - Throws: An error of type `ValidationError.invalidPassword` if the password is invalid.
    func execute(password: String) throws {
        let passwordPattern =
            // At least 8 characters
            #"(?=.{8,})"# +

            // At least one capital letter
            #"(?=.*[A-Z])"# +
                
            // At least one lowercase letter
            #"(?=.*[a-z])"# +
                
            // At least one digit
            #"(?=.*\d)"#

        let result = password.range(
            of: passwordPattern,
            options: .regularExpression
        )

        guard result != nil else { throw ValidationError.invalidPassword }
    }
}
