//
//  MembersRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.04.2024.
//

protocol MembersRepository {
    func remove(with uid: String, from guild: Guild) async throws
    func updateScore(to score: Double, in guild: Guild) async throws
}
