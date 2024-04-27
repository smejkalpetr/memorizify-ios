//
//  StorylinesUITests.swift
//  MemorizifyUITests
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import XCTest

final class StorylinesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLogInCreateNewStorylineLogOut() throws {
        let app = XCUIApplication()
        app.launch()

        let logInButton = app.buttons["Log In"]
        logInButton.tap()
        
        let emailElementsQuery = app.scrollViews.otherElements.containing(.staticText, identifier:"EMAIL")
        emailElementsQuery.children(matching: .textField).element.tap()
        emailElementsQuery.children(matching: .textField).element.typeText("pesmejkal@post.cz")
        emailElementsQuery.children(matching: .secureTextField).element.tap()
        emailElementsQuery.children(matching: .secureTextField).element.typeText("Ahoj12345")
        logInButton.tap()
        
        app.tabBars["Tab Bar"].buttons["Storylines"].tap()
     
        app.collectionViews.children(matching: .cell).element(boundBy: 0).images["transparent_placeholder"].tap()
        app.buttons["Setup Storyline"].tap()
        app.buttons["Done"].tap()
        
        app.tabBars["Tab Bar"].buttons["Settings"].tap()
        
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages").element.swipeUp()
        app.collectionViews.buttons["Logout"].tap()
    }
}
