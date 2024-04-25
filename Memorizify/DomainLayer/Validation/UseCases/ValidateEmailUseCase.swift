//
//  ValidateEmailUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

protocol ValidateEmailUseCase {
    func execute(email: String) throws
}

struct ValidateEmailUseCaseImpl: ValidateEmailUseCase {
    
    init() {}
    
    func execute(email: String) throws {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )

        guard result != nil else { throw ValidationError.invalidEmail }
    }
}
