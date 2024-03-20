//
//  KeychainTests.swift
//  MemorizifyTests
//
//  Created by Petr Šmejkal on 20.03.2024.
//

import XCTest
@testable import Memorizify

final class KeychainTests: XCTestCase {
    
    var provider: KeychainProvider!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        provider = BasicKeychainProvider()
    }
    
    override func tearDownWithError() throws {
        provider = nil
        try super.tearDownWithError()
    }
    
    func testAddAndRead() {
        let key = KeychainKey.exampleKey
        let value = "TestValue"
        XCTAssertNoThrow(try provider.add(key, value: value))
        
        XCTAssertNoThrow(try {
            let retrievedValue = try provider.read(key)
            XCTAssertEqual(retrievedValue, value)
        }())
    }
    
    func testReadNonexistentKey() {
        let key = KeychainKey.nonexistentKey
        XCTAssertThrowsError(try provider.read(key)) { error in
            XCTAssertEqual(error as? KeychainError, KeychainError.valueForKeyNotFound)
        }
    }
    
    func testAddAndRemove() {
        let key = KeychainKey.exampleKey
        let value = "TestValue"
        XCTAssertNoThrow(try provider.add(key, value: value))
        
        XCTAssertNoThrow(try provider.remove(key))
        
        XCTAssertThrowsError(try provider.read(key)) { error in
            XCTAssertEqual(error as? KeychainError, KeychainError.valueForKeyNotFound)
        }
    }
    
    func testRemoveNonexistentKey() {
        let key = KeychainKey.nonexistentKey
        XCTAssertNoThrow(try provider.remove(key))
    }
    
    func testRemoveAll() {
        let keys: [KeychainKey] = [.exampleKey, .anotherKey]
        for key in keys {
            XCTAssertNoThrow(try provider.add(key, value: "TestValue"))
        }
        
        XCTAssertNoThrow(try provider.removeAll())
        
        for key in keys {
            XCTAssertThrowsError(try provider.read(key)) { error in
                XCTAssertEqual(error as? KeychainError, KeychainError.valueForKeyNotFound)
            }
        }
    }
    
    func testRemoveAllExcept() {
        let keysToKeep: [KeychainKey] = [.exampleKey, .anotherKey]
        let keysToRemove = KeychainKey.allCases.filter { !keysToKeep.contains($0) }
        
        for key in keysToKeep {
            XCTAssertNoThrow(try provider.add(key, value: "TestValue"))
        }
        
        for key in keysToRemove {
            XCTAssertNoThrow(try provider.add(key, value: "TestValue"))
        }
        
        XCTAssertNoThrow(try provider.removeAll(except: keysToKeep))
        
        for key in keysToKeep {
            XCTAssertNoThrow(try provider.read(key))
        }
        
        for key in keysToRemove {
            XCTAssertThrowsError(try provider.read(key)) { error in
                XCTAssertEqual(error as? KeychainError, KeychainError.valueForKeyNotFound)
            }
        }
    }
}
