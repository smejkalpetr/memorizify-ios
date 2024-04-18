//
//  GuildDetailViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI
import Resolver

final class GuildDetailViewModel: ObservableObject {
    
    static let studyIntervalRange = 0...60.0
    static let breakIntervalRange = 0...15.0
    
    @Published var state: State
    
    @Injected private var removeGuildMemberUseCase: RemoveGuildMemberUseCase
    @Injected private var sendGuildInvitationUseCase: SendGuildInvitationUseCase
    @Injected private var deleteGuildUseCase: DeleteGuildUseCase
    @Injected private var loadGuildUseCase: LoadGuildUseCase
    @Injected private var getCurrentUserUseCase: GetCurrentUserUseCase
    @Injected private var getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase
    
    struct State {
        var isLoading = false
        var isListLoading = false
        var isInviteBottomSheetPresented = false
        var isUpdateBottomSheetPresented = false
        var alert: AlertData?
        var user: User?
        var guild: Guild
        var studyIntervalMinutes = 30.0
        var breakIntervalMinutes = 5.0
        
        init(guild: Guild) {
            self.guild = guild
        }
    }
    
    init(guild: Guild) {
        self.state = State(guild: guild)
    }
    
    @MainActor
    func removeUserFromGuild(userUid: String?) {
        let alertData = AlertData(
            title: "Failed to delete",
            message: "There was an error when deleting member!"
        )
        
        guard let userUid else {
            state.alert = alertData
            return
        }
        
        Task {
            do {
                try await removeGuildMemberUseCase.execute(userUid: userUid, from: state.guild)
                await refreshGuildDetail()
            } catch {
                state.alert = alertData
            }
        }
    }
    
    @MainActor
    func sendGuildInvitation(email: String) {
        Task {
            do {
                try await sendGuildInvitationUseCase.execute(to: email, guildId: state.guild.id, guildName: state.guild.name, at: Date())
                refreshGuildsOnGuildsTab()
                state.alert = AlertData(
                    title: "Invitation sent",
                    message: "Invitation has been sent to \(email). Tell them to check their Guilds to accept the invitation."
                )
            } catch InvitationsError.alreadyMember {
                state.alert = AlertData(
                    title: "Already member",
                    message: "This user is already a member of the guild."
                )
            } catch InvitationsError.alreadyInvited {
                state.alert = AlertData(
                    title: "Already invited",
                    message: "This user has already been invited to the guild. Tell them to check their pending invtitations."
                )
            } catch {
                state.alert = AlertData(
                    title: "Failed to invite friend",
                    message: "An error occured when sending invitation to friend. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func deleteGuild(completion: @escaping () -> ()) {
        Task {
            do {
                try await deleteGuildUseCase.execute(state.guild)
                completion()
            } catch {
                state.alert = AlertData(
                    title: "Failed to delete guild",
                    message: "An error occured when deleting guild. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func refreshGuildDetail() async {
        defer { state.isListLoading = false }
        state.isListLoading = true
        
        do {
            state.guild = try await loadGuildUseCase.execute(guild: state.guild)
        } catch {
            state.alert = AlertData(
                title: "Failed to fetch guild detail",
                message: "Failed to fetch guild detail data. Please try again."
            )
        }
    }
    
    @MainActor
    func getCurrentUser() async {
        defer { state.isLoading = false }
        state.isLoading = true
        
        state.user = try? await getCurrentUserUseCase.execute()
    }
    
    @MainActor
    func prepareStorylinePageTimer() -> (Storyline, StorylinePage, PomodoroTimer) {
        let record = try? state.guild.board.records.first { record in
            guard let uid = state.user?.uid else { throw UserError.notFound }
            return record.uid == uid
        }
        let finished = record?.score ?? 0.0
        
        let storyline = Storyline(
            kind: state.guild.storylineKind,
            goalHours: 0.0,
            goalMinutes: state.guild.goal,
            finished: finished,
            studyInterval: state.studyIntervalMinutes,
            breakInterval: state.breakIntervalMinutes,
            guild: state.guild
        )
        
        let page = (try? getCurrentStorylinePageUseCase.execute(storyline)) ?? TestStorylinePage1()
        let timer = PomodoroTimer(duration: state.studyIntervalMinutes * 60)
        
        return (storyline, page, timer)
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    func refreshGuildsOnGuildsTab() {
        NotificationCenter.default.post(name: .refreshGuilds, object: nil)
    }
}
