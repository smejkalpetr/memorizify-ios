//
//  GuildDetailUpdateGuildView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

import SwiftUI

struct GuildDetailUpdateGuildView: View {
    
    @ObservedObject var viewModel: GuildDetailUpdateGuildViewModel
    
    var body: some View {
        VStack {
            Text("Setup guild")
                .bold()
            VStack {
                HStack {
                    Text("Hours")
                    Spacer()
                    Text("\(Int(viewModel.state.goal))")
                }
                Slider(value: $viewModel.state.goal, in: GuildDetailUpdateGuildViewModel.goalRange, step: 1)
            }
            .padding()
            VStack {
                Picker(selection: $viewModel.state.storylineKindPickerSelection, label: Text("Select storyline")) {
                    ForEach(StorylineKind.allCases) { storylineKind in
                        Text(storylineKind.rawValue)
                            .tag(storylineKind.rawValue)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            .padding()
            Spacer()
            Button {
                viewModel.updateGuild()
            } label: {
                if viewModel.state.isLoading {
                    ProgressView()
                } else {
                    Text("Update")
                }
            }
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
    }
}

#Preview {
    GuildDetailUpdateGuildView(
        viewModel: GuildDetailUpdateGuildViewModel(
            guild: Guild(
                name: "",
                board: Board(
                    records: []
                ),
                leaderUid: "",
                goal: 0.0,
                storylineKind: .testStoryline(TestStoryline())
            )
        ) {}
    )
}
