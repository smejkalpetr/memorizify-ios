//
//  SettingsRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

import UIKit

struct SettingsRepositoryImpl: SettingsRepository {
    
    init() {}
    
    func openSystemSettings() throws {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { throw SettingsError.settingsUrlNotExists }
        UIApplication.shared.open(url)
    }
}
