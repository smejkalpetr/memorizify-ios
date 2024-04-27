//
//  SettingsDeleteAccountView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

import SwiftUI

struct SettingsDeleteAccountView: View {
    
    @ObservedObject var viewModel: SettingsDeleteAccountViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                deleteAccountForm
            }
            Spacer()
            deleteAccountButton
        }
        .padding()
        .background {
            backgroundImage
        }
        .onReceive(Notification.Name.logout.publisher) { _ in
            router.logOutAfterDelete()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(String(localized: "Delete Account"))
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
        
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_settings")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var deleteAccountForm: some View {
        VStack {
            passwordField
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 5, x: 3.5, y: 3.5)
        )
    }
    
    private var passwordField: some View {
        SecureField("", text: $viewModel.state.password)
            .textFieldStyle(PrimaryTextFieldStyle(title: "Password"))
    }
    
    private var deleteAccountButton: some View {
        VStack {
            Button("Delete Account") {
                viewModel.deleteAccount()
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.isLoading))
            .opacity(viewModel.state.canDelete ? 1.0 : 0.3)
            .disabled(!viewModel.state.canDelete)
        }
    }
}

#Preview {
    SettingsDeleteAccountView(viewModel: SettingsDeleteAccountViewModel())
}
