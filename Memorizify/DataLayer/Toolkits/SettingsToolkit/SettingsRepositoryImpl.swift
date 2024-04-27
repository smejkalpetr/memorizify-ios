//
//  SettingsRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

import UIKit

/// Implementation of the SettingsRepository protocol.
struct SettingsRepositoryImpl: SettingsRepository {
    
    /// Initializes a new instance of SettingsRepositoryImpl.
    init() {}
    
    /// Opens the system settings.
    func openSystemSettings() throws {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { throw SettingsError.settingsUrlNotExists }
        UIApplication.shared.open(url)
    }
}
