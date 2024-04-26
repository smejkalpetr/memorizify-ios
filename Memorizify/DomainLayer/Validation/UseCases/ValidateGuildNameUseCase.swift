//
//  ValidateGuildNameUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 26.04.2024.
//

import Foundation

protocol ValidateGuildNameUseCase {
    func execute(name: String) throws
}

struct ValidateGuildNameUseCaseImpl: ValidateGuildNameUseCase {
    
    init() {}
    
    func execute(name: String) throws {
        let nameRegEx = "^[0-9a-zA-Z_ ]{2,32}$"
        
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        guard namePred.evaluate(with: name) else { throw ValidationError.invalidGuildName }
    }
}
