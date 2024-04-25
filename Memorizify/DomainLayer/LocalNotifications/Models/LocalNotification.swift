//
//  LocalNotification.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import Foundation

struct LocalNotification {
    
    // MARK: Properties
    
    let title: String
    let message: String
    let identifier: String?
    
    // MARK: Initialization
    
    init(title: LocalizedStringResource, message: LocalizedStringResource, identifier: String? = nil) {
        self.title = String(localized: title)
        self.message = String(localized: message)
        self.identifier = identifier
    }
    
    init(copy: LocalNotification, title: LocalizedStringResource? = nil, message: LocalizedStringResource? = nil, identifier: String? = nil) {
        if let title = title {
            self.title = String(localized: title)
        } else {
            self.title = copy.title
        }
        
        if let message = message {
            self.message = String(localized: message)
        } else {
            self.message = copy.message
        }

        self.identifier = identifier ?? copy.identifier
    }
}
