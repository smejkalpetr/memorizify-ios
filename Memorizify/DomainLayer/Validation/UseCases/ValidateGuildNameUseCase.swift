//
//  ValidateGuildNameUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 26.04.2024.
//

import Foundation

/// Validates the format of a guild name.
protocol ValidateGuildNameUseCase {
    
    /// Validates the format of the guild name.
    /// - Parameter name: The guild name to validate.
    func execute(name: String) throws
}

/// Implementation of the ValidateGuildNameUseCase protocol.
struct ValidateGuildNameUseCaseImpl: ValidateGuildNameUseCase {
    
    /// Initializes the ValidateGuildNameUseCaseImpl instance.
    init() {}
    
    /// Validates the format of the guild name.
    /// - Parameter name: The guild name to validate.
    /// - Throws: An error of type `ValidationError.invalidGuildName` if the guild name does not match the required format.
    func execute(name: String) throws {
        let nameRegEx = "^[0-9a-zA-Z_ ]{2,32}$"
        
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        guard namePred.evaluate(with: name) else { throw ValidationError.invalidGuildName }
    }
}
