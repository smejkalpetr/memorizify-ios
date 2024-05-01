//
//  GuildDetailView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI

struct GuildDetailView: View {
    
    @ObservedObject var viewModel: GuildDetailViewModel
    
    @ObservedObject var networkMonitor = NetworkMonitor()
    
    @EnvironmentObject var router: Router
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List {
            if !networkMonitor.isConnected {
                disconnectedState
            } else if viewModel.state.isLoading {
                guildDetailLoading
            } else if viewModel.state.isInErrorState {
                guildDetailError
            } else {
                guildDetailLoaded
            }
        }
        .padding()
        .shadow(radius: 5, x: 3.5, y: 3.5)
        .background {
            backgroundImage
        }
        .scrollContentBackground(.hidden)
        .refreshable { viewModel.refreshGuildDetail() }
        .navigationTitle(viewModel.state.guild.name)
        .onFirstAppear {
            viewModel.getCurrentUser()
            viewModel.refreshGuildDetail()
        }
        .onReceive(Notification.Name.refreshGuildDetail.publisher) { _ in
            Task { viewModel.refreshGuildDetail() }
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
    
    @ViewBuilder
    private var guildDetailLoading: some View {
        Section() {
            ZStack(alignment: .bottomLeading) {
                guildDetailLoadingImageNarrow
                guildDetailLoadingTextVertical
            }
            .animatePlaceholder(isLoading: $viewModel.state.isLoading)
        }
        .listRowInsets(EdgeInsets())
        Section() {
            ZStack(alignment: .bottomLeading) {
                guildDetailLoadingImageFull
                guildDetailLoadingTextVertical
            }
            .animatePlaceholder(isLoading: $viewModel.state.isLoading)
        }
        .listRowInsets(EdgeInsets())
        Section() {
            ZStack(alignment: .bottomLeading) {
                guildDetailLoadingImageFull
                guildDetailLoadingTextHorizontalFull
            }
            .animatePlaceholder(isLoading: $viewModel.state.isLoading)
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var guildDetailLoadingImageFull: some View {
        ZStack(alignment: .bottomLeading) {
            Image("transparent_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
        }
    }
    
    private var guildDetailLoadingImageNarrow: some View {
        ZStack(alignment: .bottomLeading) {
            Image("transparent_placeholder_narrow")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
        }
    }
    
    private var guildDetailLoadingTextVertical: some View {
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
    
    private var guildDetailLoadingTextHorizontalFull: some View {
        VStack {
            ForEach(0..<4) { _ in
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 25)
                        .padding([.horizontal, .bottom])
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.35))
                        .frame(width: 80, height: 25)
                        .padding([.horizontal, .bottom])
                }
            }
        }
    }
    
    private var guildDetailLoadingTextHorizontalNarrow: some View {
        VStack {
            ForEach(0..<4) { _ in
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 25)
                        .padding([.horizontal, .bottom])
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.35))
                        .frame(width: 80, height: 25)
                        .padding([.horizontal, .bottom])
                }
            }
        }
    }
    
    private var guildDetailError: some View {
        VStack {
            HStack {
                Spacer()
                Text("Oops! Failed to load the guild detail :(")
                    .bold()
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var guildDetailLoaded: some View {
        guildInfo
        timerSettings
        memberList
    }
    
    private var leaderActionsMenu: some View {
        Menu("Leader actions") {
            Button {
                viewModel.state.isInviteBottomSheetPresented = true
            } label: {
                Label("Invite Friend", systemImage: "person.fill.badge.plus")
            }
            Button() {
                viewModel.state.isUpdateBottomSheetPresented = true
            } label: {
                Label("Update Guild", systemImage: "gearshape.arrow.triangle.2.circlepath")
            }
            Button(role: .destructive) {
                viewModel.state.alert = AlertData(
                    title: "Delete Guild",
                    message: "Do you really wish to delete the guild?",
                    primaryAction: AlertData.Action(
                        title: "Cancel",
                        style: .cancel
                    ),
                    secondaryAction: AlertData.Action(
                        title: "Delete",
                        style: .destruction,
                        handler: deleteGuild
                    )
                )
            } label: {
                Label("Delete Guild", systemImage: "trash")
            }
            .disabled(viewModel.state.guild.board.records.count > 1)
        }
        .foregroundStyle(.blue)
        .padding([.horizontal, .top])
    }
    
    private var guildInfo: some View {
        Section("Guild Info") {
            VStack {
                if let user = viewModel.state.user, viewModel.state.guild.checkIsLeader(userUid: user.uid) {
                    leaderActionsMenu
                }
                guildInfoText
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var guildInfoText: some View {
        VStack {
            Text(String(localized: "Guild Goal: \(Int(viewModel.state.guild.goal))").uppercased())
                .font(.body)
                .bold()
                .opacity(0.45)
                .padding()
            Text(String(localized: "Number of members: \(viewModel.state.guild.board.records.count)").uppercased())
                .font(.caption)
                .opacity(0.45)
        }
    }
    
    private var timerSettings: some View {
        Section("Timer Settings") {
            VStack {
                timerSliders
                startButton
            }
            .padding()
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var timerSliders: some View {
        VStack {
            SliderView(
                title: "Study interval",
                range: GuildDetailViewModel.studyIntervalRange,
                valueBinding: $viewModel.state.studyIntervalMinutes
            )
            SliderView(
                title: "Break interval",
                range: GuildDetailViewModel.breakIntervalRange,
                valueBinding: $viewModel.state.breakIntervalMinutes
            )
        }
    }
    
    private var startButton: some View {
        Button() {
            let (storyline, page, timer) = viewModel.prepareStorylinePageTimer()
            viewModel.initializeStorylineTimerViewModel(storyline: storyline, page: page, timer: timer) {
                router.guildsPath.append(GuildsRoute.storylineTimer)
            }
        } label: {
            Text(String(localized: "Start").uppercased())
                .bold()
        }
        .buttonStyle(.plain)
        .foregroundStyle(.blue)
        .padding()
    }
    
    private var memberList: some View {
        Section(header: Text("Members")) {
            if viewModel.state.isListLoading {
                memberListLoading
            } else if viewModel.state.isListInErrorState {
                guildDetailListError
            } else {
                memberListLoaded
            }
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var memberListLoading: some View {
        ZStack(alignment: .bottomLeading) {
            guildDetailLoadingImageFull
            guildDetailLoadingTextHorizontalFull
        }
        .animatePlaceholder(isLoading: $viewModel.state.isListLoading)
    }
    
    private var guildDetailListError: some View {
        VStack {
            HStack {
                Spacer()
                Text("Oops! Failed to load the guild member list :(")
                    .bold()
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .padding()
    }
    
    private var memberListLoaded: some View {
        ForEach(viewModel.state.guild.board.records) { record in
            if 
                let user = viewModel.state.user,
                viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) ||
                viewModel.state.guild.checkIsLeader(userUid: user.uid)
            {
                leadersList(user: user, record: record)
            } else {
                othersList(record: record)
            }
        }
    }
    
    private func leadersList(user: User, record: BoardRecord) -> some View {
        HStack {
            scoreMarkImage(record: record)
            if viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) {
                myRecord(record)
            } else {
                othersRecord(record)
            }
        }
        .padding()
        .contextMenu {
            contextMenuButton(user: user, record: record)
        }
    }
    
    private func scoreMarkImage(record: BoardRecord) -> some View {
        if record.score >= viewModel.state.guild.goal {
            Image(systemName: "checkmark")
        } else {
            Image(systemName: "xmark")
        }
    }
    
    @ViewBuilder
    private func myRecord(_ record: BoardRecord) -> some View {
        Text(record.username)
            .bold()
        if record.isLeader {
            Image(systemName: "crown")
        }
        Spacer()
        Text("\(Int(record.score))")
            .bold()
    }
    
    @ViewBuilder
    private func othersRecord(_ record: BoardRecord) -> some View {
        Text(record.username)
        if record.isLeader {
            Image(systemName: "crown")
        }
        Spacer()
        Text("\(Int(record.score))")
    }
    
    private func contextMenuButton(user: User, record: BoardRecord) -> some View {
        Button(role: .destructive) {
            viewModel.removeUserFromGuild(userUid: record.uid)
        } label: {
            Label(
                viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) ? "Leave Guild" : "Kick from Guild",
                systemImage: viewModel.state.guild.checkIsMyRecord(userUid: user.uid, record: record) ? "door.left.hand.open" : "figure.kickboxing")
        }
        .disabled(record.isLeader)
    }
    
    private func othersList(record: BoardRecord) -> some View {
        HStack {
            if record.score >= viewModel.state.guild.goal {
                Image(systemName: "checkmark")
            } else {
                Image(systemName: "xmark")
            }
            Text(record.username)
            if record.isLeader {
                Image(systemName: "crown")
            }
            Spacer()
            Text("\(Int(record.score))")
        }
        .padding()
    }
    
    private func deleteGuild() {
        viewModel.deleteGuild() {
            presentationMode.wrappedValue.dismiss()
            viewModel.refreshGuildsOnGuildsTab()
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
                storylineKind: .plainTimerStoryline(PlainTimerStoryline())
            )
        )
    )
}
