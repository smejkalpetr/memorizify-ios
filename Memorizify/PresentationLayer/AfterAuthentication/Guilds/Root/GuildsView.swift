//
//  GuildsView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI

struct GuildsView: View {
    
    @ObservedObject var viewModel: GuildsViewModel
    
    @ObservedObject var networkMonitor = NetworkMonitor()
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack(path: $router.guildsPath) {
            List {
                if !networkMonitor.isConnected {
                    disconnectedState
                } else {
                    invitationsSection
                    guildsSection
                }
            }
            .listRowSpacing(25)
            .padding()
            .shadow(radius: 5, x: 3.5, y: 3.5)
            .background {
                backgroundImage
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(String(localized: router.tab.rawValue))
            .navigationBarTitleDisplayMode(.large)
            .onFirstAppear {
                viewModel.refreshData()
            }
            .alert(item: Binding<AlertData?>(
                get: { viewModel.state.alert },
                set: { _ in viewModel.dismissAlert() }
            )) { alert in .init(alert) }
            .refreshable { viewModel.refreshData() }
            .sheet(isPresented: $viewModel.state.isBottomSheetPresented) {
                GuildSetupView(viewModel: GuildSetupViewModel())
            }
            .onReceive(Notification.Name.refreshGuilds.publisher) { _ in
                Task { await viewModel.loadMyGuilds() }
            }
            .onReceive(Notification.Name.refreshInvitations.publisher) { _ in
                Task { await viewModel.loadMyInvitations() }
            }
            .navigationDestination(for: GuildsRoute.self) { route in
                switch route {
                case .showGuildDetail:
                    if let vm = viewModel.state.guildDetailViewModel {
                        GuildDetailView(viewModel: vm)
                            .environmentObject(router)
                    }
                case .storylineTimer:
                    if let vm = viewModel.state.guildDetailViewModel?.state.storylineTimerViewModel {
                        StorylineTimerView(viewModel: vm)
                    }
                }
            }
        }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_guilds")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var disconnectedState: some View {
        VStack {
            disconnectedStateImage
            disconnectedStateText
        }
    }
    
    private var disconnectedStateImage: some View {
        HStack {
            Spacer()
            Image(systemName: "wifi.exclamationmark")
                .font(.largeTitle)
                .foregroundStyle(Color("primary_color"))
            Spacer()
        }
        .padding()
    }
    
    private var disconnectedStateText: some View {
        HStack {
            Spacer()
            Text("No Internet Connection")
                .bold()
                .font(.title3)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding([.horizontal, .bottom])
    }
    
    private var invitationsSection: some View {
        Section("Invitations") {
            if viewModel.state.isInvitationsLoading {
                invitationsLoading
            } else if viewModel.state.isInvitationsInErrorState {
                invitationsError
            } else if viewModel.state.invitations.isEmpty {
                invitationsEmpty
            } else {
                invitationsLoaded
            }
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var invitationsLoading: some View {
        ZStack(alignment: .bottomLeading) {
            invitationsImage
            invitationsLoadingText
        }
        .listRowInsets(EdgeInsets())
        .animatePlaceholder(isLoading: $viewModel.state.isInvitationsLoading)
    }
    
    private var invitationsImage: some View {
        Image("transparent_placeholder_narrow")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
    
    private var invitationsLoadingText: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 100, height: 25)
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.35))
                    .frame(width: 150, height: 20)
                    .padding([.horizontal, .bottom])
                Spacer()
            }
        }
    }
    
    private var invitationsError: some View {
        VStack {
            HStack {
                Spacer()
                Text("Oops! Failed to load the invitations :(")
                    .bold()
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .padding()
    }
    
    private var invitationsEmpty: some View {
        ZStack {
            invitationsEmptyImage
            invitationsEmptyText
        }
    }
    
    private var invitationsEmptyText: some View {
        Text(String(localized: "No pending invitaions").uppercased())
            .font(.footnote)
            .opacity(0.75)
    }
    
    private var invitationsEmptyImage: some View {
        ZStack(alignment: .bottomLeading) {
            Image("transparent_placeholder_narrow")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
        }
    }
    
    private var invitationsLoaded: some View {
        ForEach(viewModel.state.invitations) { invitation in
            HStack {
                Spacer()
                invitationBody(invitation: invitation)
                Spacer()
            }
            .padding()
        }
    }
    
    private func invitationBody(invitation: Invitation) -> some View {
        VStack{
            invitationInfoText(for: invitation)
            invitationButtons(invitation: invitation)
        }
    }
    
    private func invitationInfoText(for invitation: Invitation) -> some View {
        VStack {
            HStack {
                Text(String(localized: "Invitation from").uppercased())
                    .font(.footnote)
                    .opacity(0.45)
                Text("\(invitation.senderNickname)")
                    .bold()
            }
            HStack {
                Text(String(localized: "to guild").uppercased())
                    .font(.footnote)
                    .opacity(0.45)
                Text("\(invitation.guildName)")
                    .bold()
            }
        }
    }
    
    private func invitationButtons(invitation: Invitation) -> some View {
        HStack {
            Button {
                viewModel.acceptInvitation(invitation)
            } label: {
                VStack {
                    if viewModel.state.acceptingInvitation == invitation  {
                        ProgressView()
                    } else {
                        Text("Accept")
                            .bold()
                            .padding()
                    }
                }
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
            Button {
                viewModel.declineInvitation(invitation)
            } label: {
                VStack {
                    if viewModel.state.decliningInvitation == invitation  {
                        ProgressView()
                    } else {
                        Text("Decline")
                            .foregroundStyle(.red)
                            .padding()
                    }
                }
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
        }
    }
    
    private var guildsSection: some View {
        Section("Guilds") {
            if viewModel.state.isGuildsLoading {
                guildsLoading
            } else if viewModel.state.isGuildsInErrorState {
                guildsError
            } else if viewModel.state.guilds.isEmpty {
                guildsEmpty
            } else {
                guildsLoaded
                createGuildTile
            }
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var guildsLoading: some View {
        ForEach(0..<3) { _ in
            ZStack(alignment: .bottomLeading) {
                guildsLoadingImage
                guildsLoadingText
            }
            .animatePlaceholder(isLoading: $viewModel.state.isGuildsLoading)
        }
    }
    
    private var guildsLoadingImage: some View {
        ZStack(alignment: .bottomLeading) {
            Image("transparent_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
        }
    }
    
    private var guildsLoadingText: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 100, height: 25)
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.35))
                    .frame(width: 150, height: 20)
                    .padding([.horizontal, .bottom])
                Spacer()
            }
        }
    }
    
    private var guildsError: some View {
        VStack {
            HStack {
                Spacer()
                Text("Oops! Failed to load the guilds :(")
                    .bold()
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .padding()
    }
    
    private var guildsEmpty: some View {
        ZStack {
            guildsEmptyImage
            guildsEmptyText
        }
    }
    
    private var guildsEmptyImage: some View {
        Image("transparent_placeholder")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
    
    private var guildsEmptyText: some View {
        VStack {
            Text("No guilds yet")
                .bold()
                .padding()
            Text("Get an invite from a fiend or")
            Button("create a new guild!") {
                viewModel.state.isBottomSheetPresented = true
            }
        }
    }
    
    private var guildsLoaded: some View {
        ForEach(viewModel.state.guilds) { guild in
            ZStack(alignment: .bottomLeading) {
                guildImage(guild: guild)
                guildBody(guild: guild)
            }
            .listRowInsets(EdgeInsets())
        }
    }
    
    private func guildBody(guild: Guild) -> some View {
        Button() {
            viewModel.initializeGuildDetailViewModel(with: guild) {
                router.guildsPath.append(GuildsRoute.showGuildDetail)
            }
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(guild.name)")
                    .font(.title)
                    .bold()
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text(guild.storylineKind.rawValue)
                    .font(.body)
                    .bold()
                    .opacity(0.45)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text(String(localized: "Members: \(guild.board.records.count)").uppercased())
                    .font(.caption)
                    .opacity(0.45)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
            .padding()
        }
    }
    
    private func guildImage(guild: Guild) -> some View {
        getGuildImage(guild: guild)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
    
    private func getGuildImage(guild: Guild) -> Image {
        switch guild.storylineKind {
        case .testStoryline:
            return Image("transparent_placeholder")
        case .plainTimerStoryline:
            return Image("transparent_placeholder")
        }
    }
    
    private var createGuildTile: some View {
        ZStack(alignment: .center) {
            createGuildImage
            Button() {
                viewModel.state.isBottomSheetPresented = true
            } label: {
                Text(String(localized: "Tap here to create a new guild").uppercased())
                    .font(.footnote)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
            .padding()
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var createGuildImage: some View {
        Image("transparent_placeholder_narrow")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
}

#Preview {
    GuildsView(viewModel: GuildsViewModel())
}
