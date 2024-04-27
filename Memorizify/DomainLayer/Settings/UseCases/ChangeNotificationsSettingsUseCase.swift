//
//  ChangeNotificationsSettingsUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

/// Use case for changing notifications settings.
protocol ChangeNotificationsSettingsUseCase {
    
    /// Executes the change notifications settings use case.
    func execute() throws
}

/// Implementation of the change notifications settings use case.
struct ChangeNotificationsSettingsUseCaseImpl: ChangeNotificationsSettingsUseCase {
    
    private let settingsRepository: SettingsRepository
    
    /// Initializes the change notifications settings use case with the provided settings repository.
    /// - Parameter settingsRepository: The settings repository to use.
    init(settingsRepository: SettingsRepository) {
        self.settingsRepository = settingsRepository
    }
    
    /// Executes the change notifications settings use case by opening the system settings.
    func execute() throws {
        try settingsRepository.openSystemSettings()
    }
}
