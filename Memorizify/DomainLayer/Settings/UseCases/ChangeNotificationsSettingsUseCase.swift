//
//  ChangeNotificationsSettingsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

protocol ChangeNotificationsSettingsUseCase {
    func execute() throws
}

struct ChangeNotificationsSettingsUseCaseImpl: ChangeNotificationsSettingsUseCase {
    
    private let settingsRepository: SettingsRepository
    
    init(settingsRepository: SettingsRepository) {
        self.settingsRepository = settingsRepository
    }
    
    func execute() throws {
        try settingsRepository.openSystemSettings()
    }
}
