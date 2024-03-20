//
//  KeychainProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

protocol KeychainProvider {
    func add(_ key: KeychainKey, value: String) throws
    func read(_ key: KeychainKey) throws -> String
    func remove(_ key: KeychainKey) throws
    func removeAll() throws
    func removeAll(except values: [KeychainKey]) throws
}
