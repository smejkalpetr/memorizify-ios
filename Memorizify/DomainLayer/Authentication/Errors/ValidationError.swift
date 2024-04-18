//
//  ValidationError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

enum ValidationError: Error {
    case invalidName
    case invalidNickname
    case invalidEmail
    case invalidPassword
    case invalidRepeatedPassword
}
