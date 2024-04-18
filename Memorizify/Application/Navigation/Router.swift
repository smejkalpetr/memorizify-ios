//
//  Router.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI
import Resolver

final class Router: ObservableObject {
    @Published private(set) var isLoggedIn = false
    @Published private(set) var hasSeenOnboarding = false
    
    @Published var authenticationPath = NavigationPath()
    @Published var homePath = NavigationPath()
    @Published var storylinesPath = NavigationPath()
    @Published var boardPath = NavigationPath()
    @Published var guildsPath = NavigationPath()
    @Published var settingsPath = NavigationPath()
    
    @Published var tab: Tab = .home
    
    @Injected private var logOutUseCase: LogOutUseCase
    @Injected private var isUserLoggedInUseCase: IsUserLoggedInUseCase
    @Injected private var checkHasUserSeenOnboardingUseCase: CheckHasUserSeenOnboardingUseCase
    @Injected private var saveHasUserSeenOnboardingUseCase: SaveHasUserSeenOnboardingUseCase
    
    func initialize() {
        checkIsUserLoggedIn()
        checkHasUserSeenOnboarding()
    }
    
    func clearAllPaths() {
        authenticationPath = NavigationPath()
        homePath = NavigationPath()
        storylinesPath = NavigationPath()
        boardPath = NavigationPath()
        guildsPath = NavigationPath()
        settingsPath = NavigationPath()
    }
    
    func logIn() {
        clearAllPaths()
        checkIsUserLoggedIn()
    }
    
    func logOut() {
        clearAllPaths()
        try? logOutUseCase.execute()
        checkIsUserLoggedIn()
    }
    
    func saveHasUserSeenOnboarding() {
        try? saveHasUserSeenOnboardingUseCase.execute()
        checkHasUserSeenOnboarding()
    }
    
    func checkIsUserLoggedIn() {
        isLoggedIn = isUserLoggedInUseCase.execute()
    }
    
    func checkHasUserSeenOnboarding() {
        hasSeenOnboarding = checkHasUserSeenOnboardingUseCase.execute()
    }
}
