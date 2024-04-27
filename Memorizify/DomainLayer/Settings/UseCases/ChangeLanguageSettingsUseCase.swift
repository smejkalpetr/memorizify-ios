//
//  ChangeLanguageSettingsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

/// Use case for changing language settings.
protocol ChangeLanguageSettingsUseCase {
    
    /// Executes the change language settings use case.
    func execute() throws
}

/// Implementation of the change language settings use case.
struct ChangeLanguageSettingsUseCaseImpl: ChangeLanguageSettingsUseCase {
    
    private let settingsRepository: SettingsRepository
    
    /// Initializes the change language settings use case with the provided settings repository.
    /// - Parameter settingsRepository: The settings repository to use.
    init(settingsRepository: SettingsRepository) {
        self.settingsRepository = settingsRepository
    }
    
    /// Executes the change language settings use case by opening the system settings.
    func execute() throws {
        try settingsRepository.openSystemSettings()
    }
}
