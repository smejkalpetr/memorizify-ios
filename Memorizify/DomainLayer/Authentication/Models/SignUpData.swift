//
//  SignUpData.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

/// Represents the data required for user sign-up.
struct SignUpData {
    
    // MARK: Properties
    
    /// The username for the new account.
    let username: String
    
    /// The email address for the new account.
    let email: String
    
    /// The password for the new account.
    let password: String
    
    /// The repeated password for the new account to confirm.
    let repeatedPassword: String
    
    // MARK: Initialization
    
    /// Initializes the SignUpData instance.
    /// - Parameters:
    ///   - username: The username for the new account.
    ///   - email: The email address for the new account.
    ///   - password: The password for the new account.
    ///   - repeatedPassword: The repeated password for the new account to confirm.
    init(username: String, email: String, password: String, repeatedPassword: String) {
        self.username = username
        self.email = email
        self.password = password
        self.repeatedPassword = repeatedPassword
    }
}
