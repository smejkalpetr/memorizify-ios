//
//  LaunchPerformanceUITests.swift
//  MemorizifyUITests
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import XCTest

final class LaunchPerformanceUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLaunchCpuUtilization() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTCPUMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLaunchMemoryUtilization() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTMemoryMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLaunchStorageUtilization() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTStorageMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
