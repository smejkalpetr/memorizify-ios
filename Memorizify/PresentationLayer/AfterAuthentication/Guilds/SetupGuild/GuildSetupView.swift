//
//  GuildSetupView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI

struct GuildSetupView: View {
    
    @ObservedObject var viewModel: GuildSetupViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
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
                Slider(value: $viewModel.state.goal, in: GuildSetupViewModel.goalRange, step: 1)
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
            VStack {
                TextField("Name", text: $viewModel.state.name, onEditingChanged: { isStart in
                    guard (!isStart) else { return }
                    viewModel.validateNameField()
                })
                    .textFieldStyle(PrimaryTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                Text(viewModel.state.nameError)
                    .foregroundStyle(.red)
                TextField("Friend's email", text: $viewModel.state.email)
                    .onChange(of: viewModel.state.email) { Task { await viewModel.validateEmailField(ignoreEmpty: true) } }
                    .textFieldStyle(PrimaryTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                Text(viewModel.state.emailError)
                    .foregroundStyle(.red)
                Button("Add friend") {
                    viewModel.addFriendEmail()
                }
                    .disabled(!viewModel.state.canAddFriendEmail)
                Text("You can add up to 10 friends")
                    .foregroundStyle(viewModel.state.emailInvitations.count > 10 ? .red : .primary)
                ForEach(viewModel.state.emailInvitations, id: \.self) { email in
                    HStack {
                        Text(email)
                        Spacer()
                        Button("Remove") {
                            viewModel.removeFriendEmail(email)
                        }
                    }
                }
            }
            Spacer()
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                Button("Create guild") {
                    viewModel.createGuild() { presentationMode.wrappedValue.dismiss() }
                }
                .disabled(!viewModel.state.canCreateGuild)
            }
        }
        .padding()
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
    }
}

#Preview {
    GuildSetupView(viewModel: GuildSetupViewModel())
}
