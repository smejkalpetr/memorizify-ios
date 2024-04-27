//
//  BoardUITests.swift
//  MemorizifyUITests
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import XCTest

final class BoardsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLogInShowBoardRefreshLogOut() throws {
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
        
        app.tabBars["Tab Bar"].buttons["Board"].tap()
        app.collectionViews.staticTexts["TOP 10"].swipeDown()
        
        
        app.tabBars["Tab Bar"].buttons["Settings"].tap()
        
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages").element.swipeUp()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Logout"]/*[[".cells.buttons[\"Logout\"]",".buttons[\"Logout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
