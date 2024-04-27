//
//  SettingsRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

/// Repository for managing settings.
protocol SettingsRepository {
    
    /// Opens the system settings.
    func openSystemSettings() throws
}
