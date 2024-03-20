//
//  UserDefaultsProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

protocol UserDefaultsProvider {
    func add(_ key: UserDefaultsKey, value: String) throws
    func read(_ key: UserDefaultsKey) throws -> String
    func remove(_ key: UserDefaultsKey) throws
    func removeAll() throws
}
