//
//  UserRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

protocol UserRepository {
    func getCurrentUser() async throws -> User
    func update(user: User) async throws
}
