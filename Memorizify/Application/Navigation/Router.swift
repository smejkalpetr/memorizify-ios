//
//  Router.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI
import Resolver

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    @Published private(set) var isLoggedIn = false
    @Published var tab: Tab = .home
    
    @Injected private var logOutUseCase: LogOutUseCase
    @Injected private var isUserLoggedInUseCase: IsUserLoggedInUseCase
    
    func clearPath() {
        path = NavigationPath()
    }
    
    func logIn() {
        clearPath()
        checkIsUserLoggedIn()
    }
    
    func logOut() {
        clearPath()
        try? logOutUseCase.execute()
        checkIsUserLoggedIn()
    }
    
    func checkIsUserLoggedIn() {
        isLoggedIn = isUserLoggedInUseCase.execute()
    }
}
