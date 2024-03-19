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
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])[A-Za-z0-9]{8,}$"

        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        guard passwordPred.evaluate(with: password) else { throw ValidationError.invalidPassword }
    }
}

