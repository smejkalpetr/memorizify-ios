//
//  SettingsRepositoryTests.swift
//  MemorizifyTests
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import XCTest
@testable import Memorizify

// Protocol representing UIApplication's static properties and methods
protocol UIApplicationProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

// Conform UIApplication to UIApplicationProtocol
extension UIApplication: UIApplicationProtocol {}

// MockUIApplication provides a mock implementation of UIApplicationProtocol
class MockUIApplication: UIApplicationProtocol {
    var openURLCalled = false
    var urlToOpen: URL?

    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?) {
        openURLCalled = true
        urlToOpen = url
    }
}

class SettingsRepositoryTests: XCTestCase {
    var repository: SettingsRepositoryImpl!
    var mockApplication: MockUIApplication!

    override func setUp() {
        super.setUp()
        mockApplication = MockUIApplication()
        repository = SettingsRepositoryImpl()
    }

    func testOpenSystemSettingsCalled() {
        XCTAssertFalse(mockApplication.openURLCalled, "openURL should not be called before calling openSystemSettings")
    }
}

