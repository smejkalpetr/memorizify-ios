//
//  InvitationsRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation

protocol InvitationsRepository {
    func add(to email: String, guildId: String, guildName: String, at date: Date) async throws
    func getAll() async throws -> [Invitation]
    func getInvitationsForUser(with email: String) async throws -> [Invitation]
    func getMyInvitations() async throws -> [Invitation]
    func accept(_ invitation: Invitation) async throws
    func decline(_ invitation: Invitation) async throws
    func update(_ invitation: Invitation) async throws
    func deleteAllForGuild(_ guild: Guild) async throws
}
