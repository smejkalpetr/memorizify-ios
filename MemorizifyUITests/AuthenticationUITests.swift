//
//  AuthenticationUITests.swift
//  MemorizifyUITests
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import XCTest

final class AuthenticationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLogInLogOut() {
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
        
        app.tabBars["Tab Bar"].buttons["Settings"].tap()
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages").element.swipeUp()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Logout"]/*[[".cells.buttons[\"Logout\"]",".buttons[\"Logout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testFailedSignUp() {
        let app = XCUIApplication()
        app.launch()
        
        let logInButton = app.buttons["Sign Up"]
        logInButton.tap()
        
        let usernameElementsQuery = app.scrollViews.otherElements.containing(.staticText, identifier:"USERNAME")
        usernameElementsQuery.children(matching: .textField).element(boundBy: 0).tap()
        usernameElementsQuery.children(matching: .textField).element(boundBy: 0).typeText("newUser")
        
        usernameElementsQuery.children(matching: .textField).element(boundBy: 1).tap()
        usernameElementsQuery.children(matching: .textField).element(boundBy: 1).typeText("email@domain.com")
        
        usernameElementsQuery.children(matching: .secureTextField).element(boundBy: 0).tap()
        usernameElementsQuery.children(matching: .secureTextField).element(boundBy: 0).typeText("Password123")
        
        usernameElementsQuery.children(matching: .secureTextField).element(boundBy: 1).tap()
        usernameElementsQuery.children(matching: .secureTextField).element(boundBy: 1).typeText("Password123")
        
        // Check if the button is disabled due to unconfirmed Privacy Policy
        let signUpButtonBelowForm = app.buttons["Sign Up"]
        XCTAssertFalse(signUpButtonBelowForm.isEnabled)
    }
    
    func testResetPassword() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Log In"].tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.buttons["Reset it now!"].tap()
        
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Please, fill in your email and we will attempt to send you a password reset link").children(matching: .textField).element.tap()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Please, fill in your email and we will attempt to send you a password reset link").children(matching: .textField).element.typeText("pesmejkal@post.cz")
        
        app.buttons["Reset Password"].tap()
        app.buttons["Back"].tap()
    }
    
    func testPrivacyAndPolicyLink() {
        let app = XCUIApplication()
        app.launch()
                
        app.buttons["Sign Up"].tap()
        
        app.scrollViews.otherElements.buttons["Privacy Policy"].tap()
    }
}

