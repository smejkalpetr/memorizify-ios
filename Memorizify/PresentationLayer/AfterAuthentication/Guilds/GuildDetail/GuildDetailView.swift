//
//  GuildDetailView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI

struct GuildDetailView: View {
    
    @ObservedObject var viewModel: GuildDetailViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if viewModel.state.isLoading {
                
            } else {
                if let user = viewModel.state.user, viewModel.state.guild.checkIsLeader(userUid: user.uid) {
                    Menu("Actions") {
                        Button {
                            viewModel.state.isInviteBottomSheetPresented = true
                        } label: {
                            Label("Invite friend", systemImage: "person.fill.badge.plus")
                        }
                        Button() {
                            viewModel.state.isUpdateBottomSheetPresented = true
                        } label: {
                            Label("Update guild", systemImage: "gearshape.arrow.triangle.2.circlepath")
                        }
                        Button(role: .destructive) {
                            viewModel.deleteGuild() {
                                presentationMode.wrappedValue.dismiss()
                                viewModel.refreshGuildsOnGuildsTab()
                            }
                        } label: {
                            Label("Delete guild", systemImage: "trash")
                        }
                        .disabled(viewModel.state.guild.board.records.count > 1)
                    }
                }
                VStack {
                    Text("Goal: \(viewModel.state.guild.goal)")
                }
                VStack {
                    VStack {
                        HStack {
                            Text("Study interval")
                            Spacer()
                            Text("\(Int(viewModel.state.studyIntervalMinutes))")
                        }
                        Slider(value: $viewModel.state.studyIntervalMinutes, in: GuildDetailViewModel.studyIntervalRange, step: 1)
                        HStack {
                            Text("Break interval")
                            Spacer()
                            Text("\(Int(viewModel.state.breakIntervalMinutes))")
                        }
                        Slider(value: $viewModel.state.breakIntervalMinutes, in: GuildDetailViewModel.breakIntervalRange, step: 1)
                    }
                    Button("Start") {
                        let (storyline, page, timer) = viewModel.prepareStorylinePageTimer()
                        router.guildsPath.append(GuildsRoute.storylineTimer(storyline, page, timer))
                    }
                    .padding()
                }
                .padding()
                List {
                    Section(header: Text("Members")) {
                        if viewModel.state.isListLoading {
                            ProgressView()
                        } else {
                            ForEach(viewModel.state.guild.board.records) { record in
                                if let user = viewModel.state.user, viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) || viewModel.state.guild.checkIsLeader(userUid: user.uid) {
                                    HStack {
                                        if record.score >= viewModel.state.guild.goal {
                                            Image(systemName: "checkmark")
                                        } else {
                                            Image(systemName: "xmark")
                                        }
                                        if viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) {
                                            Text(record.nickname)
                                                .bold()
                                            if record.isLeader {
                                                Image(systemName: "crown")
                                            }
                                            Spacer()
                                            Text("\(record.score)")
                                                .bold()
                                        } else {
                                            Text(record.nickname)
                                            if record.isLeader {
                                                Image(systemName: "crown")
                                            }
                                            Spacer()
                                            Text("\(record.score)")
                                        }
                                    }
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            viewModel.removeUserFromGuild(userUid: record.uid)
                                        } label: {
                                            Label(
                                                viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) ? "Leave guild" : "Kick from guild",
                                                systemImage: viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) ? "door.left.hand.open" : "figure.kickboxing")
                                        }
                                        .disabled(record.isLeader)
                                    }
                                } else {
                                    HStack {
                                        if record.score >= viewModel.state.guild.goal {
                                            Image(systemName: "checkmark")
                                        } else {
                                            Image(systemName: "xmark")
                                        }
                                        Text(record.nickname)
                                        if record.isLeader {
                                            Image(systemName: "crown")
                                        }
                                        Spacer()
                                        Text("\(record.score)")
                                    }
                                }
                            }
                            .listRowBackground(Color.yellow)
                        }
                    }
                }
                .background {
                    Color.red
                }
                .scrollContentBackground(.hidden)
                .refreshable { await viewModel.refreshGuildDetail() }

            }
        }
        .navigationTitle(viewModel.state.guild.name)
        .task { 
            await viewModel.getCurrentUser()
            await viewModel.refreshGuildDetail()
        }
        .onReceive(Notification.Name.refreshGuildDetail.publisher) { _ in
            Task { await viewModel.refreshGuildDetail() }
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
        .sheet(isPresented: $viewModel.state.isInviteBottomSheetPresented) {
            GuildDetailAddFriendView(viewModel: GuildDetailAddFriendViewModel() { email in
                viewModel.sendGuildInvitation(email: email)
                viewModel.state.isInviteBottomSheetPresented = false
            })
            .presentationDetents([.medium])
        }
        .sheet(isPresented: $viewModel.state.isUpdateBottomSheetPresented) {
            GuildDetailUpdateGuildView(viewModel: GuildDetailUpdateGuildViewModel(guild: viewModel.state.guild) {
                viewModel.state.isUpdateBottomSheetPresented = false
            })
        }
    }
}

#Preview {
    GuildDetailView(
        viewModel: GuildDetailViewModel(
            guild: Guild(
                id: "",
                name: "",
                board: Board(
                    records: []
                ),
                leaderUid: "",
                goal: 0.0,
                storylineKind: .testStoryline(TestStoryline())
            )
        )
    )
}
