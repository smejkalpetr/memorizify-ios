//
//  ValidateNicknameUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Foundation

protocol ValidateNicknameUseCase {
    func execute(nickname: String) throws
}

struct ValidateNicknameUseCaseImpl: ValidateNicknameUseCase {
    
    init() {}
    
    func execute(nickname: String) throws {
        let nameRegEx = "^[0-9a-zA-Z_ ]{2,32}$"
        
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        guard namePred.evaluate(with: nickname) else { throw ValidationError.invalidNickname }
    }
}
