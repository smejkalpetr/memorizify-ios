//
//  Router.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI
import Resolver

/// Manages the navigation and state of the application.
final class Router: ObservableObject {
    
    /// Indicates whether the user is logged in.
    @Published private(set) var isLoggedIn = false
    
    /// Indicates whether the user has seen the onboarding screens.
    @Published private(set) var hasSeenOnboarding = false
    
    /// Indicates whether the onboarding screens should be shown.
    @Published private(set) var isShowingOnboarding = false
    
    /// Navigation path for the authentication flow.
    @Published var authenticationPath = NavigationPath()
    
    /// Navigation path for the home screen.
    @Published var homePath = NavigationPath()
    
    /// Navigation path for the storylines screen.
    @Published var storylinesPath = NavigationPath()
    
    /// Navigation path for the board screen.
    @Published var boardPath = NavigationPath()
    
    /// Navigation path for the guilds screen.
    @Published var guildsPath = NavigationPath()
    
    /// Navigation path for the settings screen.
    @Published var settingsPath = NavigationPath()
    
    /// Currently selected tab.
    @Published var tab: Tab = .home
    
    /// Use case for logging out the user.
    @Injected private var logOutUseCase: LogOutUseCase
    
    /// Use case for checking if the user is logged in.
    @Injected private var isUserLoggedInUseCase: IsUserLoggedInUseCase
    
    /// Use case for checking if the user has seen the onboarding screens.
    @Injected private var checkHasUserSeenOnboardingUseCase: CheckHasUserSeenOnboardingUseCase
    
    /// Use case for saving the information that the user has seen the onboarding screens.
    @Injected private var saveHasUserSeenOnboardingUseCase: SaveHasUserSeenOnboardingUseCase
    
    /// Initializes the router.
    func initialize() {
        checkIsUserLoggedIn()
        checkHasUserSeenOnboarding()
        
        // Show onboarding screens if the user is not logged in and has not seen onboarding
        if !isLoggedIn && !hasSeenOnboarding { isShowingOnboarding = true }
    }
    
    /// Clears all navigation paths.
    func clearAllPaths() {
        authenticationPath = NavigationPath()
        homePath = NavigationPath()
        storylinesPath = NavigationPath()
        boardPath = NavigationPath()
        guildsPath = NavigationPath()
        settingsPath = NavigationPath()
    }
    
    /// Clears the authentication navigation path.
    func clearAuthenticationPath() {
        authenticationPath = NavigationPath()
    }
    
    /// Clears the home navigation path.
    func clearHomePath() {
        homePath = NavigationPath()
    }
    
    /// Clears the storylines navigation path.
    func clearStorylinesPath() {
        storylinesPath = NavigationPath()
    }
    
    /// Clears the guilds navigation path.
    func clearGuildsPath() {
        guildsPath = NavigationPath()
    }
    
    /// Clears the board navigation path.
    func clearBoardPath() {
        boardPath = NavigationPath()
    }
    
    /// Clears the settings navigation path.
    func clearSettingsPath() {
        settingsPath = NavigationPath()
    }
    
    /// Logs the user in.
    func logIn() {
        clearAllPaths()
        checkIsUserLoggedIn()
    }
    
    /// Logs the user out.
    func logOut() {
        clearAllPaths()
        try? logOutUseCase.execute()
        checkIsUserLoggedIn()
        RootState.resetData()
    }
    
    /// Logs the user out after deleting the account.
    func logOutAfterDelete() {
        isLoggedIn = false
        clearAllPaths()
        RootState.resetData()
    }
    
    /// Saves the information that the user has seen the onboarding screens.
    func saveHasUserSeenOnboarding() {
        try? saveHasUserSeenOnboardingUseCase.execute()
        checkHasUserSeenOnboarding()
    }
    
    /// Checks if the user is logged in.
    func checkIsUserLoggedIn() {
        isLoggedIn = isUserLoggedInUseCase.execute()
    }
    
    /// Checks if the user has seen the onboarding screens.
    func checkHasUserSeenOnboarding() {
        hasSeenOnboarding = checkHasUserSeenOnboardingUseCase.execute()
    }
}
