//
//  GuildsRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

protocol GuildsRepository {
    func add(name: String, goal: TimeInterval, storylineKindRawValue: String) async throws -> String
    func getAllGuildsForUser(with email: String) async throws -> [Guild]?
    func getMyGuilds() async throws -> [Guild]?
    func getAllGuilds() async throws -> [Guild]?
    func update(_ guild: Guild) async throws
    func delete(_ guild: Guild) async throws
    func add(_ guild: Guild) async throws
    func load(_ guild: Guild) async throws -> Guild
}
