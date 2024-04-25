//
//  GuildDetailViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI
import Resolver

final class GuildDetailViewModel: ObservableObject {
    
    static let studyIntervalRange = 5...60.0
    static let breakIntervalRange = 1...15.0
    
    @Published var state: State
    
    @Injected private var removeGuildMemberUseCase: RemoveGuildMemberUseCase
    @Injected private var sendGuildInvitationUseCase: SendGuildInvitationUseCase
    @Injected private var deleteGuildUseCase: DeleteGuildUseCase
    @Injected private var loadGuildUseCase: LoadGuildUseCase
    @Injected private var getCurrentUserUseCase: GetCurrentUserUseCase
    @Injected private var getCurrentStorylinePageUseCase: GetCurrentStorylinePageUseCase
    
    struct State {
        var alert: AlertData?
        var isLoading = false
        var isListLoading = false
        var isInErrorState = false
        var isListInErrorState = false
        var isInviteBottomSheetPresented = false
        var isUpdateBottomSheetPresented = false
        
        var user: User?
        var guild: Guild
        var studyIntervalMinutes = 30.0
        var breakIntervalMinutes = 5.0
        
        var storylineTimerViewModel: StorylineTimerViewModel?
        
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
            title: "User Remove Failed",
            message: "An error occured when removing the user. Please try again."
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
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
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
                    title: "Invitation Sent",
                    message: "Invitation has been sent to user with the following email address: \(email). Please, tell them to check their Guilds to accept the invitation."
                )
            } catch InvitationsError.alreadyMember {
                state.alert = AlertData(
                    title: "Already Member",
                    message: "This user is already a member of the guild."
                )
            } catch InvitationsError.alreadyInvited {
                state.alert = AlertData(
                    title: "Already Invited",
                    message: "This user has already been invited to the guild. Tell them to check their pending invtitations, please."
                )
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Invitation Failed",
                    message: "An error occured when sending invitation to your friend. Please try again."
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
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Guild Deletion Failed",
                    message: "An error occured when deleting the guild. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func refreshGuildDetail() {
        Task {
            defer { state.isListLoading = false }
            state.isListLoading = true
            
            do {
                state.guild = try await loadGuildUseCase.execute(guild: state.guild)
                state.isListInErrorState = false
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.isListInErrorState = true
                state.alert = AlertData(
                    title: "Guild Detail Loading Failed",
                    message: "Failed to load the guild data. Please try again."
                )
            }
        }
    }
    
    @MainActor
    func getCurrentUser() {
        Task {
            defer { state.isLoading = false }
            state.isLoading = true
            
            do {
                state.user = try await getCurrentUserUseCase.execute()
                state.isInErrorState = false
            } catch {
                state.isInErrorState = true
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
            }
        }
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
    
    func initializeStorylineTimerViewModel(storyline: Storyline, page: StorylinePage, timer: PomodoroTimer, completion: () -> ()) {
        state.storylineTimerViewModel = StorylineTimerViewModel(storyline: storyline, page: page, timer: timer, timerKind: .guild)
        completion()
    }
    
    func refreshGuildsOnGuildsTab() {
        NotificationCenter.default.post(name: .refreshGuilds, object: nil)
    }
}
