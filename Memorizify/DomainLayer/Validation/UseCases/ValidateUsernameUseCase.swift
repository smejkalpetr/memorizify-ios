//
//  ValidateUsernameUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

/// Validates the username format.
protocol ValidateUsernameUseCase {
    
    /// Validates the provided username.
    /// - Parameter username: The username to validate.
    func execute(username: String) throws
}

/// Implementation of the ValidateUsernameUseCase protocol.
struct ValidateUsernameUseCaseImpl: ValidateUsernameUseCase {
    
    /// Initializes the ValidateUsernameUseCaseImpl instance.
    init() {}
    
    /// Validates the provided username.
    /// - Parameter username: The username to validate.
    /// - Throws: An error of type `ValidationError.invalidUsername` if the username is invalid.
    func execute(username: String) throws {
        let nameRegEx = "^[0-9a-zA-Z_ ]{2,32}$"
        
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        guard namePred.evaluate(with: username) else { throw ValidationError.invalidUsername }
    }
}
