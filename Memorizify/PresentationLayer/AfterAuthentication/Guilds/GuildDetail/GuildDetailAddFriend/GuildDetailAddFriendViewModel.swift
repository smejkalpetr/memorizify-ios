//
//  GuildDetailAddFriendViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI
import Resolver

final class GuildDetailAddFriendViewModel: ObservableObject {
 
    let completion: (String) -> ()
    
    @Published var state = State()
    
    @Injected private var validateEmailUseCase: ValidateEmailUseCase
    
    struct State {
        var alert: AlertData?
        
        var email = ""
        var emailError = ""
        
        var canAddFriend: Bool {
            [emailError].allSatisfy { $0 == "" } &&
            [email].allSatisfy { !$0.isEmpty }
        }
    }
    
    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }
    
    @MainActor
    func validateEmailField() {
        state.emailError = ""
        
        do {
            try validateEmailUseCase.execute(email: state.email)
        } catch ValidationError.invalidEmail {
            state.emailError = "Wrong Email Format"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
            )
        }
    }
    
    @MainActor
    func addFriend() {
        validateEmailField()
        guard state.canAddFriend else { return }
        completion(state.email)
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
}
