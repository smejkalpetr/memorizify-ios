//
//  SignUpData.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

struct SignUpData {
    let name: String
    let nickname: String
    let email: String
    let password: String
    let repeatedPassword: String
    
    init(name: String, nickname: String, email: String, password: String, repeatedPassword: String) {
        self.name = name
        self.nickname = nickname
        self.email = email
        self.password = password
        self.repeatedPassword = repeatedPassword
    }
}
