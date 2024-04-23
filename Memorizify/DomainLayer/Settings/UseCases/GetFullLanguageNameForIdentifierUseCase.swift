//
//  GetFullLanguageNameForIdentifierUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

protocol GetFullLanguageNameForIdentifierUseCase {
    func execute(identifier: String) -> LanguageSetting
}

struct GetFullLanguageNameForIdentifierUseCaseImpl: GetFullLanguageNameForIdentifierUseCase {
    
    init() {}
    
    func execute(identifier: String) -> LanguageSetting {
        #warning("FIXME: Use localization when available!")
        return LanguageSetting(identifier: identifier)
    }
}
