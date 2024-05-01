//
//  GuildDetailUpdateGuildView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 18.04.2024.
//

import SwiftUI
import Foundation

struct GuildDetailUpdateGuildView: View {
    
    @ObservedObject var viewModel: GuildDetailUpdateGuildViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                topNotch
                guildSettings
            }
            Spacer()
            updateButton
        }
        .background {
            backgroundImage
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_guilds")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Color.black.opacity(colorScheme == .dark ? 0.5 : 0.3)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    private var topNotch: some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 65, height: 6)
                .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.6) : Color.black.opacity(0.5))
                .padding(.top, 12)
            Spacer()
        }
    }

    private var guildSettings: some View {
        VStack {
            hoursSlider
            storylinePickerSection
        }
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 3, x: 2, y: 2)
        )
        .padding([.top, .horizontal])
    }
    
    private var hoursSlider: some View {
        VStack {
            groupTitle("Guild Goal")
            SliderView(title: "Hours", range: GuildDetailUpdateGuildViewModel.goalRange, valueBinding: $viewModel.state.goal)
        }
        .padding()
    }
    
    private func groupTitle(_ title: LocalizedStringResource) -> some View {
        VStack {
            HStack {
                Text(String(localized: title).uppercased())
                    .font(.callout)
                    .foregroundStyle(colorScheme == .dark ? .white.opacity(0.6) : .gray)
                Spacer()
            }
            Divider()
        }
        .padding(.bottom)
    }
    
    private var storylinePickerSection: some View {
        VStack {
            groupTitle("Storyline")
            storylinePicker
        }
        .padding()
    }
    
    private var storylinePicker: some View {
        Picker(selection: $viewModel.state.storylineKindPickerSelection, label: Text("Select Storyline")) {
            #warning("TODO: Remove next line when more storyline kinds are available!")
            ForEach(0..<3) { index in
                ForEach(StorylineKind.allCases) { storylineKind in
                    Text(storylineKind.rawValue)
                        .tag(storylineKind.rawValue + String(index))
                }
            }
        }
        .pickerStyle(MenuPickerStyle())
        .tint(.blue)
        .padding([.horizontal, .bottom])
    }
    
    private var updateButton: some View {
        Button("Update Guild") {
            viewModel.updateGuild()
        }
        .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isLoading))
        .padding([.horizontal, .bottom])
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
                storylineKind: .plainTimerStoryline(PlainTimerStoryline())
            )
        ) {}
    )
}
