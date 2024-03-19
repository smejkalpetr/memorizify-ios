//
//  FirebaseUserError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

enum FirebaseUserError: Error {
    case notFound
    case emailNotVerified
    case alreadyVerified
}
