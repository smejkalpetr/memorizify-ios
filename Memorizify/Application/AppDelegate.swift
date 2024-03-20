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
}
