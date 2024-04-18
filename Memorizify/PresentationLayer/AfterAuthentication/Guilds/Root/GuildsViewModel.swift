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
        var hasInitialyLoadedGuilds = false
        var isInvitationsLoading = false
        var isGuildsLoading = false
        var decliningInvitation: Invitation?
        var acceptingInvitation: Invitation?
        var alert: AlertData?
        var isBottomSheetPresented = false
        var invitations: [Invitation] = []
        var guilds: [Guild] = []
    }
    
    @MainActor
    func loadMyInvitations() async {
        defer { state.isInvitationsLoading = false }
        state.isInvitationsLoading = true
        
        do {
            state.invitations = try await loadMyInvitationsUseCase.execute()
        } catch {
            state.alert = AlertData(
                title: "Error loading invitations",
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
        } catch {
            state.alert = AlertData(
                title: "Error loading guilds",
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
                    message: "You are already a member of this guild. Declining invitation."
                )
                try await declineGuildInvitationUseCase.execute(invitation)
            } catch {
                print("Error: \(error)")
                state.alert = AlertData(
                    title: "Failed to accept invitation",
                    message: "An error occured when accepting invitation. Please try again."
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
                print("Error: \(error)")
                state.alert = AlertData(
                    title: "Failed to decline invitation",
                    message: "An error occured when declining invitation. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func refreshData() async {
        await loadMyInvitations()
        await loadMyGuilds()
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    private func refreshInvitationsOnGuildsTab() {
        NotificationCenter.default.post(name: .refreshInvitations, object: nil)
    }
    
    private func refreshGuildsOnGuildsTab() {
        NotificationCenter.default.post(name: .refreshGuilds, object: nil)
    }
}
