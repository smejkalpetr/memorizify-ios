//
//  GuildSetupView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI
import Foundation

struct GuildSetupView: View {
    
    @ObservedObject var viewModel: GuildSetupViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                topNotch
                guildSettings
                addFriendSection
            }
            Spacer()
            footerButton
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
            guildNameTextField
            errorText(viewModel.state.nameError)
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
        .padding()
    }
    
    private var guildNameTextField: some View {
        VStack {
            groupTitle("Guild Setup")
            TextField("", text: $viewModel.state.name, onEditingChanged: { isStart in
                guard (!isStart) else { return }
                viewModel.validateNameField()
            })
            .textFieldStyle(PrimaryTextFieldStyle(title: "Name"))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        }
        .padding([.horizontal, .top])
    }
    
    private func errorText(_ text: LocalizedStringResource) -> some View {
        Text(text)
            .font(.footnote)
            .foregroundStyle(.red)
            .padding(.horizontal)
    }
        
    private var hoursSlider: some View {
        VStack {
            SliderView(title: "Hours", range: StorylineSetupViewModel.goalHoursRange, valueBinding: $viewModel.state.goal)
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
            storylinePicker
        }
        .padding()
    }
    
    private var storylinePicker: some View {
        Picker(selection: $viewModel.state.storylineKindPickerSelection, label: Text("Select Storyline")) {
            ForEach(StorylineKind.allCases) { storylineKind in
                Text(storylineKind.rawValue)
                    .tag(storylineKind.rawValue)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .tint(.blue)
        .padding([.horizontal, .bottom])
    }
    
    private var addFriendSection: some View {
        VStack {
            friendsEmailTextField
            errorText(viewModel.state.emailError)
            addFriendButton
            friendList
            friendCountText
        }
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 3, x: 2, y: 2)
        )
        .padding([.horizontal])
    }
    
    private var friendsEmailTextField: some View {
        VStack {
            groupTitle("Invite Friends")
            TextField("", text: $viewModel.state.email)
                .onChange(of: viewModel.state.email) { Task { await viewModel.validateEmailField(ignoreEmpty: true) } }
                .textFieldStyle(PrimaryTextFieldStyle(title: "Friend's email"))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
        .padding([.horizontal, .top]) 
    }
    
    private var addFriendButton: some View {
        Button("Add Friend") {
            viewModel.addFriendEmail()
        }
        .foregroundStyle(.blue)
        .disabled(!viewModel.state.canAddFriendEmail)
    }
    
    private var friendCountText: some View {
        Text("You can add up to 10 friends")
            .foregroundStyle(viewModel.state.emailInvitations.count > 10 ? .red : .primary)
            .font(.caption)
            .opacity(0.45)
            .padding([.horizontal, .bottom])
    }
    
    private var friendList: some View {
        VStack {
            ForEach(viewModel.state.emailInvitations, id: \.self) { email in
                HStack {
                    Text(email)
                    Spacer()
                    Button("Remove") {
                        viewModel.removeFriendEmail(email)
                    }
                    .foregroundStyle(.blue)
                }
            }
        }
        .padding()
    }
    
    private var footerButton: some View {
        VStack {
            Button("Create Guild") {
                viewModel.createGuild() { presentationMode.wrappedValue.dismiss() }
            }
            .disabled(!viewModel.state.canCreateGuild)
            .overlay(Color.black.opacity(viewModel.state.canCreateGuild ? 0.0 : 0.5).cornerRadius(5))
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isLoading))
            .padding()
        }
    }
}

#Preview {
    GuildSetupView(viewModel: GuildSetupViewModel())
}
