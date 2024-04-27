//
//  UserDefaultsProviderMock.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

class UserDefaultsProviderMock: UserDefaultsProvider {
    
    private var data: [String: String] = [:]

    func add(_ key: UserDefaultsKey, value: String) throws {
        data[key.rawValue] = value
    }

    func read(_ key: UserDefaultsKey) throws -> String {
        guard let value = data[key.rawValue] else {
            throw UserDefaultsError.valueForKeyNotFound
        }
        return value
    }

    func remove(_ key: UserDefaultsKey) throws {
        data[key.rawValue] = nil
    }

    func removeAll() throws {
        data.removeAll()
    }
}
