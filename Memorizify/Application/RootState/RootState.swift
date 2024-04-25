//
//  RootState.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 25.04.2024.
//


/*
    This class serves as a workaround for a bug that prevents the proper deinitialization
    of the app state (view models). The issue lies within Apple's implementation, occurring
    when the root view passes a certain class by reference as an environment object.
    Consequently, this object fails to deinitialize upon user logout, resulting in retained view
    model data. As a result, if a user switches accounts, they may still see data from the
    previous user's session. This class is closely associated with the AppView.
    
    More info in the Stack Overflow question:
        https://stackoverflow.com/questions/74840544/why-is-viewmodel-not-deiniting-with-a-navigationview
 */

final class RootState {
    
    static var isAppShowing = true
    
    // For a very short time change to EmptyView in AppView
    // so that the RootView is deinitialized
    static func resetData() {
        isAppShowing = false
        isAppShowing = true
    }
}
