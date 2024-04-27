//
//  LogInData.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

/// Represents the data required for user login.
struct LogInData {
    
    // MARK: Properties
    
    /// The email address associated with the user account.
    let email: String
    
    /// The password associated with the user account.
    let password: String
    
    // MARK: Initialization
    
    /// Initializes the LogInData instance.
    /// - Parameters:
    ///   - email: The email address associated with the user account.
    ///   - password: The password associated with the user account.
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
