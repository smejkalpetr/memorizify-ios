//
//  LanguageSetting.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

import Foundation

/// Represents language settings.
enum LanguageSetting: LocalizedStringResource {
    case en = "English"
    case cs = "Czech"
    case unknown
    
    /// Initializes a `LanguageSetting` instance with the given identifier.
    ///
    /// - Parameter identifier: The identifier of the language setting.
    init(identifier: String) {
        switch identifier {
        case "en":
            self = .en
        case "cs":
            self = .cs
        default:
            self = .unknown
        }
    }
}
