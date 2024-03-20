//
//  UserDefaultsTests.swift
//  MemorizifyTests
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import XCTest
@testable import Memorizify

class BasicUserDefaultsProviderTests: XCTestCase {
    
    var provider: UserDefaultsProvider!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        provider = BasicUserDefaultsProvider()
        
        try? provider.remove(.exampleKey)
        try? provider.remove(.anotherKey)
        try? provider.remove(.nonexistentKey)
    }

    override func tearDownWithError() throws {
        provider = nil
        try super.tearDownWithError()
    }
    
    func testAddAndRead() {
        let key = UserDefaultsKey.exampleKey
        let value = "TestValue"
        XCTAssertNoThrow(try provider.add(key, value: value))
        
        XCTAssertNoThrow(try {
            let retrievedValue = try provider.read(key)
            XCTAssertEqual(retrievedValue, value)
        }())
    }
    
    func testReadNonexistentKey() {
        let key = UserDefaultsKey.nonexistentKey
        XCTAssertThrowsError(try provider.read(key)) { error in
            XCTAssertEqual(error as? UserDefaultsError, UserDefaultsError.valueForKeyNotFound)
        }
    }
    
    func testAddAndRemove() {
        let key = UserDefaultsKey.exampleKey
        let value = "TestValue"
        XCTAssertNoThrow(try provider.add(key, value: value))
        
        XCTAssertNoThrow(try provider.remove(key))
        
        XCTAssertThrowsError(try provider.read(key)) { error in
            XCTAssertEqual(error as? UserDefaultsError, UserDefaultsError.valueForKeyNotFound)
        }
    }

    func testRemoveMultipleKeys() {
        let key1 = UserDefaultsKey.exampleKey
        let key2 = UserDefaultsKey.anotherKey

        UserDefaults.standard.set("Some value 1", forKey: key1.rawValue)
        UserDefaults.standard.set("Some value 2", forKey: key2.rawValue)

        XCTAssertNoThrow(try provider.remove(key1))
        XCTAssertNoThrow(try provider.remove(key2))

        XCTAssertNil(UserDefaults.standard.object(forKey: key1.rawValue))
        XCTAssertNil(UserDefaults.standard.object(forKey: key2.rawValue))
    }
    
    func testRemoveAll() {
        let keys: [UserDefaultsKey] = [.exampleKey, .anotherKey] // Add more keys if necessary
        for key in keys {
            XCTAssertNoThrow(try provider.add(key, value: "TestValue"))
        }
        
        XCTAssertNoThrow(try provider.removeAll())
        
        for key in keys {
            XCTAssertThrowsError(try provider.read(key)) { error in
                XCTAssertEqual(error as? UserDefaultsError, UserDefaultsError.valueForKeyNotFound)
            }
        }
    }
}
