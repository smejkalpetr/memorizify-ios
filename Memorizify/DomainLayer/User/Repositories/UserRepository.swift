//
//  UserRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

protocol UserRepository {
    func getCurrentUser() async throws -> User
    func getUser(with email: String) async throws -> User
    func getUser(uid: String) async throws -> User
    func update(user: User) async throws
    func removeGuildForCurrentUser(_ guild: Guild) async throws
    func delete(user: User) async throws
}
