//
//  ValidateNameUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

import Foundation

protocol ValidateNameUseCase {
    func execute(name: String) throws
}

struct ValidateNameUseCaseImpl: ValidateNameUseCase {
    
    init() {}
    
    func execute(name: String) throws {
        let nameRegEx = "^[0-9a-zA-Z_ ]{2,32}$"
        
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        guard namePred.evaluate(with: name) else { throw ValidationError.invalidName }
    }
}
