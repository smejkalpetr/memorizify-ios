//
//  GuildsViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI
import Resolver

final class GuildsViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected private var loadMyInvitationsUseCase: LoadMyInvitationsUseCase
    @Injected private var loadMyGuildsUseCase: LoadMyGuildsUseCase
    @Injected private var acceptGuildInvitationUseCase: AcceptGuildInvitationUseCase
    @Injected private var declineGuildInvitationUseCase: DeclineGuildInvitationUseCase
    
    struct State {
        var alert: AlertData?
        var isInvitationsLoading = false
        var isGuildsLoading = false
        var isInvitationsInErrorState = false
        var isGuildsInErrorState = false
        var isBottomSheetPresented = false
        
        var decliningInvitation: Invitation?
        var acceptingInvitation: Invitation?
        
        var invitations: [Invitation] = []
        var guilds: [Guild] = []
        
        var guildDetailViewModel: GuildDetailViewModel?
    }
    
    @MainActor
    func loadMyInvitations() async {
        defer { state.isInvitationsLoading = false }
        state.isInvitationsLoading = true
        
        do {
            state.invitations = try await loadMyInvitationsUseCase.execute()
            state.isInvitationsInErrorState = false
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.isInvitationsInErrorState = true
            state.alert = AlertData(
                title: "Loading Invitations Failed",
                message: "An error occured when loading invitations. Please try again."
            )
        }
    }
    
    @MainActor
    func loadMyGuilds() async {
        defer { state.isGuildsLoading = false }
        state.isGuildsLoading = true
        
        do {
            let guilds = try await loadMyGuildsUseCase.execute()
            state.guilds = guilds ?? []
            state.isGuildsInErrorState = false
        } catch {
            NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            state.isGuildsInErrorState = true
            state.alert = AlertData(
                title: "Loading Guilds Failed",
                message: "An error occured when loading guilds. Please try again."
            )
        }
    }
    
    @MainActor
    func acceptInvitation(_ invitation: Invitation) {
        Task {
            defer { state.acceptingInvitation = nil }
            state.acceptingInvitation = invitation
            
            do {
                try await acceptGuildInvitationUseCase.execute(invitation)
                refreshInvitationsOnGuildsTab()
                refreshGuildsOnGuildsTab()
            } catch InvitationsError.alreadyMember {
                state.alert = AlertData(
                    title: "Already member",
                    message: "You are already a member of this guild. The invitation will be declined."
                )
                try await declineGuildInvitationUseCase.execute(invitation)
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Accepting Invitation Failed",
                    message: "An error occured when accepting the invitation. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func declineInvitation(_ invitation: Invitation) {
        Task {
            defer { state.decliningInvitation = nil }
            state.decliningInvitation = invitation
            
            do {
                try await declineGuildInvitationUseCase.execute(invitation)
                refreshInvitationsOnGuildsTab()
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Declining Invitation Failed",
                    message: "An error occured when declining the invitation. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func refreshData() {
        Task {
            await loadMyInvitations()
            await loadMyGuilds()
        }
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    func initializeGuildDetailViewModel(with guild: Guild, completion: () -> ()) {
        state.guildDetailViewModel = GuildDetailViewModel(guild: guild)
        completion()
    }
    
    private func refreshInvitationsOnGuildsTab() {
        NotificationCenter.default.post(name: .refreshInvitations, object: nil)
    }
    
    private func refreshGuildsOnGuildsTab() {
        NotificationCenter.default.post(name: .refreshGuilds, object: nil)
    }
}
