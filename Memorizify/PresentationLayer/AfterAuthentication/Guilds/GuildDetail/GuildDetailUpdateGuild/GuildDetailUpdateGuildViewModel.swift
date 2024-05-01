//
//  GuildDetailUpdateGuildViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

import SwiftUI
import Resolver

final class GuildDetailUpdateGuildViewModel: ObservableObject {
    
    static let goalRange = 10...100.0
    
    private let completion: () -> ()
    
    @Published var state: State
    
    @Injected private var updateGuildUseCase: UpdateGuildUseCase
    
    struct State {
        var alert: AlertData?
        var isLoading = false
        var storylineKindPickerSelection = StorylineKind.allCases.first?.rawValue ?? StorylineKind.plainTimerStoryline(PlainTimerStoryline()).rawValue
        var goal: Double
        var guild: Guild
                
        init(guild: Guild) {
            self.guild = guild
            self.goal = floor(guild.goal / 60)
        }
    }
    
    init(guild: Guild, completion: @escaping () -> ()) {
        self.completion = completion
        self.state = State(guild: guild)
    }
    
    @MainActor
    func updateGuild() {
        Task {
            defer { state.isLoading = false }
            state.isLoading = true
            
            do {
                guard let storylineKind = StorylineKind(rawValue: state.storylineKindPickerSelection) else { throw StorylinesError.failedToInitializeFromRawValue }
                let newGuild = Guild(copy: state.guild, goal: state.goal * 60, storylineKind: storylineKind)
                try await updateGuildUseCase.execute(guild: newGuild)
                refreshGuildsOnGuildsTab()
                refreshGuildDetail()
                completion()
            } catch {
                NSLog("❌ Error in \(#file) on line \(#line): \(error.localizedDescription)")
                state.alert = AlertData(
                    title: "Updating Guild Failed",
                    message: "An error occured when updating the guild. Please try again."
                )
            }
            
        }
    }
    
    @MainActor
    func dismissAlert() {
        state.alert = nil
    }
    
    private func refreshGuildsOnGuildsTab() {
        NotificationCenter.default.post(name: .refreshGuilds, object: nil)
    }
    
    private func refreshGuildDetail() {
        NotificationCenter.default.post(name: .refreshGuildDetail, object: nil)
    }
}
