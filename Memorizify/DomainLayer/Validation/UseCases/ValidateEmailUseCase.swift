//
//  ValidateEmailUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

/// Validates the email format.
protocol ValidateEmailUseCase {
    
    /// Validates the provided email address.
    /// - Parameter email: The email address to validate.
    func execute(email: String) throws
}

/// Implementation of the ValidateEmailUseCase protocol.
struct ValidateEmailUseCaseImpl: ValidateEmailUseCase {
    
    /// Initializes the ValidateEmailUseCaseImpl instance.
    init() {}
    
    /// Validates the provided email address.
    /// - Parameter email: The email address to validate.
    /// - Throws: An error of type `ValidationError.invalidEmail` if the email address is invalid.
    func execute(email: String) throws {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPred.evaluate(with: email) else { throw ValidationError.invalidEmail }
    }
}
