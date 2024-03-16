//
//  Router.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    @Published var isLoggedIn = false
    @Published var tab: Tab = .home
}
