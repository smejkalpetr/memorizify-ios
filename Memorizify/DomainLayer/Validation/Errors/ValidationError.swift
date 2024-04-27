//
//  ValidationError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

enum ValidationError: Error {
    case invalidUsername
    case invalidEmail
    case invalidPassword
    case invalidRepeatedPassword
    case invalidGuildName
}
