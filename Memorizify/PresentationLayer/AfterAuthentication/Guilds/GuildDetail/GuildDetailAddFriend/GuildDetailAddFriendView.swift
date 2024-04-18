//
//  GuildDetailAddFriendView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import SwiftUI

struct GuildDetailAddFriendView: View {
    
    @ObservedObject var viewModel: GuildDetailAddFriendViewModel
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.state.email)
                .textFieldStyle(PrimaryTextFieldStyle())
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onChange(of: viewModel.state.email) { viewModel.validateEmailField() }
            Text(viewModel.state.emailError)
                .foregroundStyle(.red)
            Spacer()
            Button("Add friend") {
                viewModel.addFriend()
            }
        }
        .padding()
    }
}

#Preview {
    GuildDetailAddFriendView(viewModel: GuildDetailAddFriendViewModel() { _ in })
}
