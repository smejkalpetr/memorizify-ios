//
//  GuildSetupViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation
import Resolver

final class GuildSetupViewModel: ObservableObject {
    
    static let goalRange = 1...300.0
    
    @Published var state = State()
    
    @Injected private var validateNameUseCase: ValidateNameUseCase
    @Injected private var validateEmailUseCase: ValidateEmailUseCase
    @Injected private var createGuildUseCase: CreateGuildUseCase
    @Injected private var sendGuildInvitationUseCase: SendGuildInvitationUseCase
    @Injected private var getCurrentUserUseCase: GetCurrentUserUseCase
    
    struct State {
        var alert: AlertData?
        var isLoading = false
        
        var name = ""
        var email = ""
        
        var nameError: LocalizedStringResource = ""
        var emailError: LocalizedStringResource = ""
        
        var goal = (goalRange.lowerBound + goalRange.upperBound) / 2
        var emailInvitations: [String] = []
        var storylineKindPickerSelection = StorylineKind.allCases.first?.rawValue ?? StorylineKind.testStoryline(TestStoryline()).rawValue
        
        var canCreateGuild: Bool {
            [nameError].allSatisfy { $0 == "" } &&
            [name].allSatisfy { !$0.isEmpty }
        }
        
        var canAddFriendEmail: Bool {
            [emailError].allSatisfy { $0 == "" } &&
            [email].allSatisfy { !$0.isEmpty } &&
            emailInvitations.count <= 10
        }
    }
    
    @MainActor
    func validateNameField() {
        state.nameError = ""
        
        do {
            try validateNameUseCase.execute(name: state.name)
        } catch ValidationError.invalidName {
            state.nameError = "Name must be 2-32 characters long"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
            )
        }
    }
    
    @MainActor
    func validateEmailField(ignoreEmpty: Bool = false) async {
        do {
            let user = try await getCurrentUserUseCase.execute()
            guard user.email != state.email else { throw InvitationsError.alreadyMember }
            try validateEmailUseCase.execute(email: state.email)
            state.emailError = ""
        } catch ValidationError.invalidEmail {
            if !state.email.isEmpty && ignoreEmpty {
                state.emailError = "Wrong Email Format"
            }
        } catch InvitationsError.alreadyMember {
            state.emailError = "You cannot add yourself"
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.alert = AlertData(
                title: "Unknown Error",
                message: "An unknown error has occured."
            )
        }
    }
    
    @MainActor
    func validateAllFields() async {
        validateNameField()
        await validateEmailField()
    }
    
    @MainActor
    func addFriendEmail() {
        Task {
            await validateEmailField()
            guard state.canAddFriendEmail else { return }
            state.emailInvitations.append(state.email)
            state.email = ""
        }
    }
    
    @MainActor
    func removeFriendEmail(_ email: String) {
        guard let index = state.emailInvitations.firstIndex(where: { $0 == email }) else { return }
        state.emailInvitations.remove(at: index)
    }
    
    @MainActor
    func createGuild(completion: (() -> ())? = nil) {
        Task {
            defer { state.isLoading = false }
            state.isLoading = true
            
            await validateAllFields()
            guard state.canCreateGuild else { return }
            
            do {
                // Create guild
                let guildId = try await createGuildUseCase.execute(with: state.name, goal: state.goal * 60, storylineKindRawValue: state.storylineKindPickerSelection)
                
                // Invite friends
                for email in state.emailInvitations {
                    if (try? await sendGuildInvitationUseCase.execute(to: email, guildId: guildId, guildName: state.name, at: Date())) == nil {
                        state.alert = AlertData(
                            title: "Friend Invite Failed",
                            message: "An error occured when inviting friend. Please try again."
                        )
                        try? await Task.sleep(nanoseconds: 2_500_000_000)
                    }
                }
                
                completion?()
                refreshGuildTab()
            } catch InvitationsError.alreadyMember {
                // ignore this error (shouldn't occur anyways)
                NSLog("⚠️ Warning \(#file) on line \(#line): InvitationsError.alreadyMember")
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Creating Guild Failed",
                    message: "An error occured when creating a new guild. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    private func refreshGuildTab() {
        NotificationCenter.default.post(name: .refreshGuilds, object: nil)
    }
}
