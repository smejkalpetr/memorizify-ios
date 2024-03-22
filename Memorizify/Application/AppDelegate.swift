//
//  AppDelegate.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.03.2024.
//

import Foundation
import UIKit
import Firebase
import Resolver

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Register all dependencies
        Resolver.registerProviders()
        Resolver.registerRepositories()
        Resolver.registerUseCases()
        
        // Clear Keychain
        clearKeychain()
        
        // Configure Firebase
        configureFirebase()
        
        return true
    }
    
    // MARK: Private
    
    private func configureFirebase() {
        let fileName = "GoogleService-Info"
        let filePath = Bundle.main.path(forResource: fileName, ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)
        
        guard let options else { fatalError("Couldn't find Firebase configuration!") }
        
        FirebaseApp.configure(options: options)
    }
    
    private func clearKeychain() {
        let keychainProvider: KeychainProvider = Resolver.resolve()
        let userDefaultsProvider: UserDefaultsProvider = Resolver.resolve()
        
        do {
            print("running clear")
            let _ = try userDefaultsProvider.read(.hasEverRunBefore)
            print("finshed clear")
        } catch UserDefaultsError.valueForKeyNotFound {
            do {
                print("clearing keychain...")
                try keychainProvider.removeAll(except: [.hasUserSeenOnboarding])
                try userDefaultsProvider.add(.hasEverRunBefore, value: "true")
            } catch {print("caught1")}
        } catch {print("caught2")}
    }
}
