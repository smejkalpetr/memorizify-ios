//
//  LanguageSetting.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.04.2024.
//

enum LanguageSetting: String {
    #warning("FIXME: Use localization here when available!")
    case en = "English"
    case cs = "Czech"
    case unknown
    
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
