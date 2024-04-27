//
//  GetFullLanguageNameForIdentifierUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

/// Use case for getting the full language name for a given identifier.
protocol GetFullLanguageNameForIdentifierUseCase {
    
    /// Retrieves the full language name for the provided identifier.
    /// - Parameter identifier: The identifier of the language.
    /// - Returns: The corresponding `LanguageSetting`.
    func execute(identifier: String) -> LanguageSetting
}

/// Implementation of the GetFullLanguageNameForIdentifierUseCase protocol.
struct GetFullLanguageNameForIdentifierUseCaseImpl: GetFullLanguageNameForIdentifierUseCase {
    
    /// Initializes the use case.
    init() {}
    
    /// Retrieves the full language name for the provided identifier.
    /// - Parameter identifier: The identifier of the language.
    /// - Returns: The corresponding `LanguageSetting`.
    func execute(identifier: String) -> LanguageSetting {
        return LanguageSetting(identifier: identifier)
    }
}
