//
//  GuildsView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI

struct GuildsView: View {
    
    @ObservedObject var viewModel: GuildsViewModel
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.guildsPath) {
            VStack {
                ScrollView {
                    VStack {
                        if viewModel.state.isInvitationsLoading {
                            ProgressView()
                        } else if viewModel.state.invitations.isEmpty {
                            Text("No pending invitaions")
                        } else {
                            Text("Invitations")
                            ForEach(viewModel.state.invitations) { invitation in
                                VStack {
                                    Text("Invitaion from \(invitation.senderNickname)")
                                    Text("To guild \(invitation.guildName)")
                                    HStack {
                                        Button {
                                            viewModel.acceptInvitation(invitation)
                                        } label: {
//                                            if viewModel.state.acepting == invitation  {
//                                                ProgressView()
//                                            } else {
                                                Text("Accept")
//                                            }
                                        }
                                        .padding(.horizontal)
                                        Button {
                                            viewModel.declineInvitation(invitation)
                                        } label: {
                                            if viewModel.state.decliningInvitation == invitation  {
                                                ProgressView()
                                            } else {
                                                Text("Decline")
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .padding()
                                .border(.blue)
                            }
                        }
                    }
                    Divider()
                        .padding(.vertical)
                    VStack {
                        if viewModel.state.isGuildsLoading {
                            ProgressView()
                        } else if viewModel.state.guilds.isEmpty {
                            VStack {
                                Text("No guilds yet")
                                    .padding()
                                HStack {
                                    Text("Get an invite from a fiend or")
                                    Button("create a new guild!") {
                                        viewModel.state.isBottomSheetPresented = true
                                    }
                                }
                            }
                        } else {
                            Text("Guilds")
                            ForEach(viewModel.state.guilds) { guild in
                                VStack {
                                    Button(guild.name) {
                                        router.guildsPath.append(GuildsRoute.showGuildDetail(guild))
                                    }
                                }
                                .padding()
                                .border(.blue)
                            }
                            Button("Create new guild") {
                                viewModel.state.isBottomSheetPresented = true
                            }
                            .padding()
                        }
                    }
                }
                .refreshable { await viewModel.refreshData() }
                .onReceive(Notification.Name.refreshGuilds.publisher) { _ in
                    Task { await viewModel.loadMyGuilds() }
                }
                .onReceive(Notification.Name.refreshInvitations.publisher) { _ in
                    Task { await viewModel.loadMyInvitations() }
                }
            }
            .navigationDestination(for: GuildsRoute.self) { route in
                switch route {
                case let .showGuildDetail(guild):
                    GuildDetailView(viewModel: GuildDetailViewModel(guild: guild))
                        .environmentObject(router)
                case let .storylineTimer(storyline, page, timer):
                    let vm = StorylineTimerViewModel(storyline: storyline, page: page, timer: timer, timerKind: .guild)
                    StorylineTimerView(viewModel: vm)
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .task {
                if !viewModel.state.hasInitialyLoadedGuilds {
                    await viewModel.refreshData()
                    viewModel.state.hasInitialyLoadedGuilds = true
                }
            }
            .alert(item: Binding<AlertData?>(
                get: { viewModel.state.alert },
                set: { _ in viewModel.dismissAlert() }
            )) { alert in .init(alert) }
            .sheet(isPresented: $viewModel.state.isBottomSheetPresented) {
                GuildSetupView(viewModel: GuildSetupViewModel())
            }
        }
    }
}

#Preview {
    GuildsView(viewModel: GuildsViewModel())
}
