//
//  LocalNotification.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import Foundation

/// Represents a local notification in the Memorizify application.
struct LocalNotification {
    
    // MARK: Properties
    
    /// The title of the notification.
    let title: String
    
    /// The message body of the notification.
    let message: String
    
    /// An optional identifier for the notification.
    let identifier: String?
    
    // MARK: Initialization
    
    /// Initializes a new local notification.
    /// - Parameters:
    ///   - title: The title of the notification.
    ///   - message: The message body of the notification.
    ///   - identifier: An optional identifier for the notification.
    init(title: LocalizedStringResource, message: LocalizedStringResource, identifier: String? = nil) {
        self.title = String(localized: title)
        self.message = String(localized: message)
        self.identifier = identifier
    }
    
    /// Initializes a local notification by copying another notification with possible modifications.
    /// - Parameters:
    ///   - copy: The notification to copy from.
    ///   - title: The new title for the notification. If nil, keeps the original title.
    ///   - message: The new message body for the notification. If nil, keeps the original message.
    ///   - identifier: An optional new identifier for the notification. If nil, keeps the original identifier.
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
