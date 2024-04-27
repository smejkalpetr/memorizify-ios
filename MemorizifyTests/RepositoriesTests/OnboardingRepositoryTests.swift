//
//  OnboardingRepositoryTests.swift
//  MemorizifyTests
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import XCTest
@testable import Memorizify

final class OnboardingRepositoryTests: XCTestCase {
    var repository: OnboardingRepositoryImpl!
    var mockKeychainProvider: KeychainProviderMock!

    override func setUpWithError() throws {
        mockKeychainProvider = KeychainProviderMock()
        repository = OnboardingRepositoryImpl(keychainProvider: mockKeychainProvider)
    }

    func testSaveHasUserSeenOnboarding() {
        XCTAssertNoThrow(try repository.saveHasUserSeenOnboarding())

        do {
            let value = try mockKeychainProvider.read(.hasUserSeenOnboarding)
            XCTAssertEqual(value, "true")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testLoadHasUserSeenOnboarding() {
        do {
            try mockKeychainProvider.add(.hasUserSeenOnboarding, value: "true")
            let value = try repository.loadHasUserSeenOnboarding()
            XCTAssertEqual(value, "true")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
