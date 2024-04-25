//
//  ValidateRepeatedPassword.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

protocol ValidateRepeatedPasswordUseCase {
    func execute(password: String, repeatedPassword: String) throws
}

struct ValidateRepeatedPasswordImpl: ValidateRepeatedPasswordUseCase {
    
    init() {}
    
    func execute(password: String, repeatedPassword: String) throws {
        guard password == repeatedPassword else { throw ValidationError.invalidRepeatedPassword }
    }
}
