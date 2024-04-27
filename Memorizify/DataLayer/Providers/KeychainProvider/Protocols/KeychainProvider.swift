//
//  KeychainProvider.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.03.2024.
//

// NOTE: This data structure has been taken from a publicly available
//       project called "Devstack Native App" by "MateeDevs".
//       The project is available at: https://github.com/MateeDevs/devstack-native-app

protocol KeychainProvider {
    func add(_ key: KeychainKey, value: String) throws
    func read(_ key: KeychainKey) throws -> String
    func remove(_ key: KeychainKey) throws
    func removeAll() throws
    func removeAll(except values: [KeychainKey]) throws
}
