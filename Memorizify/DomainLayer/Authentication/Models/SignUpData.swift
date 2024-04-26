//
//  SignUpData.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

struct SignUpData {
    let username: String
    let email: String
    let password: String
    let repeatedPassword: String
    
    init(username: String, email: String, password: String, repeatedPassword: String) {
        self.username = username
        self.email = email
        self.password = password
        self.repeatedPassword = repeatedPassword
    }
}
