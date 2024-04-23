//
//  GuildDetailAddFriendView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI

struct GuildDetailAddFriendView: View {
    
    @ObservedObject var viewModel: GuildDetailAddFriendViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                inviteFriend
                addFriendButton
            }
        }
        .background {
            backgroundImage
        }
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
    
    private var inviteFriend: some View {
        VStack {
            emailTextField
        }
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 3, x: 2, y: 2)
        )
        .padding([.horizontal, .top])
    }
    
    private var emailTextField: some View {
        VStack {
            TextField("", text: $viewModel.state.email)
                .textFieldStyle(PrimaryTextFieldStyle(title: "Email"))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onChange(of: viewModel.state.email) { viewModel.validateEmailField() }
            errorText(viewModel.state.emailError)
        }
        .padding()
    }
    
    private func errorText(_ text: String) -> some View {
        Text(text)
            .font(.footnote)
            .foregroundStyle(.red)
            .padding(.horizontal)
    }
    
    private var addFriendButton: some View {
        Button("Invite friend") {
            viewModel.addFriend()
        }
        .disabled(!viewModel.state.canAddFriend)
        .overlay(Color.black.opacity(viewModel.state.canAddFriend ? 0.0 : 0.5).cornerRadius(5))
        .buttonStyle(PrimaryButtonStyle())
        .padding(.horizontal)
    }
}

#Preview {
    GuildDetailAddFriendView(viewModel: GuildDetailAddFriendViewModel() { _ in })
}
