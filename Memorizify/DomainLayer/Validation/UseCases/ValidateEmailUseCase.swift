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
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPred.evaluate(with: email) else { throw ValidationError.invalidEmail }
    }
}
