//
//  ValidateUsernameUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

protocol ValidateUsernameUseCase {
    func execute(username: String) throws
}

struct ValidateUsernameUseCaseImpl: ValidateUsernameUseCase {
    
    init() {}
    
    func execute(username: String) throws {
        let nameRegEx = "^[0-9a-zA-Z_ ]{2,32}$"
        
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        guard namePred.evaluate(with: username) else { throw ValidationError.invalidUsername }
    }
}
