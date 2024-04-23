//
//  ChangeLanguageSettingsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

protocol ChangeLanguageSettingsUseCase {
    func execute() throws
}

struct ChangeLanguageSettingsUseCaseImpl: ChangeLanguageSettingsUseCase {
    
    private let settingsRepository: SettingsRepository
    
    init(settingsRepository: SettingsRepository) {
        self.settingsRepository = settingsRepository
    }
    
    func execute() throws {
        try settingsRepository.openSystemSettings()
    }
}
