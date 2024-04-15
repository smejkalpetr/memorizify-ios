//
//  LocalNotification.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

struct LocalNotification {
    let title: String
    let message: String
    let identifier: String?
    
    init(title: String, message: String, identifier: String? = nil) {
        self.title = title
        self.message = message
        self.identifier = identifier
    }
    
    init(copy: LocalNotification, title: String? = nil, message: String? = nil, identifier: String? = nil) {
        self.title = title ?? copy.title
        self.message = message ?? copy.message
        self.identifier = identifier ?? copy.identifier
    }
}
