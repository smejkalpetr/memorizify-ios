//
//  SettingsView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack(path: $router.settingsPath) {
            VStack {
                List {
                    profileSection
                    accountSection
                    otherSection
                    logoutSection
                }
                .padding()
                .shadow(radius: 5, x: 3.5, y: 3.5)
                .background {
                    ZStack {
                        Image("background_settings")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                        if colorScheme == .dark {
                            Color.black.opacity(0.5)
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .task { await viewModel.getUserInfo() }
            .navigationDestination(for: SettingsRoute.self) { route in
                switch route {
                case .changePassword:
                    SettingsChangePasswordView(viewModel: SettingsChangePasswordViewModel())
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .alert(item: Binding<AlertData?>(
                get: { viewModel.state.alert },
                set: { _ in viewModel.dismissAlert() }
            )) { alert in .init(alert) }
        }
    }
    
    @ViewBuilder
    private var profileSection: some View {
        Section("Profile") {
            if let user = viewModel.state.user {
                userSectionLoaded(name: user.name, email: user.email)
            } else if viewModel.state.isUserLoading {
                userSectionLoading
            } else {
                userSectionFailedToLoad
            }
        }
    }
    
    private func userSectionLoaded(name: String, email: String) -> some View {
        HStack {
            Image("profile_avatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .shadow(radius: 4)
                )
                .padding(4)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    private var userSectionLoading: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .padding()
    }
    
    private var userSectionFailedToLoad: some View {
        HStack {
            Spacer()
            Text("Failed to load user data")
            Spacer()
        }
        .padding()
    }
    
    private var accountSection: some View {
        Section("Account") {
            changeUsernameItem
            changeEmailItem
            changePasswordItem
        }
    }
    
    private var otherSection: some View {
        Section("Other") {
            changeLanguageSettingsItem
            changeNotificationsSettingsItem
        }
    }
        
    private var logoutSection: some View {
        Section {
            logoutItem
        }
    }
    
    private var changeUsernameItem: some View {
        Button() {
            #warning("TODO: Proceed to view where user can change their username.")
        } label: {
            HStack {
                Text("Username")
                Spacer()
                Text(viewModel.state.user?.nickname ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .foregroundStyle(.primary)
    }
    
    private var changeEmailItem: some View {
        Button() {
            #warning("TODO: Proceed to view where user can change their email.")
        } label: {
            HStack {
                Text("Email")
                Spacer()
                Text(viewModel.state.user?.email ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .foregroundStyle(.primary)
    }
    
    private var changePasswordItem: some View {
        Button() {
            router.settingsPath.append(SettingsRoute.changePassword)
        } label: {
            HStack {
                Text("Change Password")
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .foregroundStyle(.primary)
    }
    
    private var changeLanguageSettingsItem: some View {
        HStack {
            Button() {
                viewModel.openLanguageSettings()
            } label: {
                HStack {
                    Text("Switch Language")
                    Spacer()
                    Text(viewModel.getLanguageName(identifier: Locale.current.language.languageCode?.identifier))
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .foregroundStyle(.primary)
        }
    }
    
    private var changeNotificationsSettingsItem: some View {
        Button() {
            viewModel.openNotificationsSettings()
        } label: {
            HStack {
                Text("Change Notifications Settings")
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .foregroundStyle(.primary)
    }
    
    private var logoutItem: some View {
        Button("Logout") {
            router.logOut()
        }
        .foregroundStyle(.red)
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
