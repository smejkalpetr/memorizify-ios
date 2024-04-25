//
//  ValidatePasswordUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

protocol ValidatePasswordUseCase {
    func execute(password: String) throws
}

struct ValidatePasswordUseCaseImpl: ValidatePasswordUseCase {
    
    init() {}
    
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

