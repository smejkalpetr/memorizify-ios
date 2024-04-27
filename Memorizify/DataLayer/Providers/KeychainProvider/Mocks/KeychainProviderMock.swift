//
//  KeychainProviderMock.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

class KeychainProviderMock: KeychainProvider {
    private var data: [String: String] = [:]

    func add(_ key: KeychainKey, value: String) throws {
        data[key.rawValue] = value
    }

    func read(_ key: KeychainKey) throws -> String {
        guard let value = data[key.rawValue] else {
            throw KeychainError.valueForKeyNotFound
        }
        return value
    }

    func remove(_ key: KeychainKey) throws {
        data[key.rawValue] = nil
    }

    func removeAll() throws {
        data.removeAll()
    }

    func removeAll(except values: [KeychainKey]) throws {
        let keysToRemove = data.keys.filter { !values.contains(KeychainKey(rawValue: $0)!) }
        for key in keysToRemove {
            data[key] = nil
        }
    }
}
