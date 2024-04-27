//
//  StorylinesRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

protocol StorylinesRepository {
    func loadAll() async throws -> [Storyline]?
    func update(_ storyline: Storyline) async throws
    func delete(_ storyline: Storyline) async throws
    func deleteAll(of userUid: String) async throws
}
