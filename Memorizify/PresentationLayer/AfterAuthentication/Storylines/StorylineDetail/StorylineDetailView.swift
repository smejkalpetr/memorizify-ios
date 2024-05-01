//
//  StorylineDetailView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.04.2024.
//

import SwiftUI

struct StorylineDetailView: View {
    
    @ObservedObject var viewModel: StorylineDetailViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            List {
                descriptionText
            }
            .shadow(radius: 5, x: 3.5, y: 3.5)
            footerButton
        }
        .background {
            backgroundImage
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(viewModel.state.kind.rawValue)
        .sheet(item: $viewModel.state.bottomSheetItem) { item in
            StorylineSetupView(viewModel: StorylineSetupViewModel(setup: .create(item)) {
                router.clearStorylinesPath()
            })
            .environmentObject(router)
        }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_storylines")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.35)
                    .edgesIgnoringSafeArea(.all)
            }
           
        }
    }
    
    private var descriptionText: some View {
        VStack {
            Text(viewModel.state.kind.getDescription())
                .font(.body)
        }
        .padding(.vertical)
        .listRowSeparator(.hidden)
    }
    
    private var footerButton: some View {
        VStack {
            Button("Setup Storyline") {
                viewModel.state.bottomSheetItem = viewModel.state.kind
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

#Preview {
    StorylineDetailView(
        viewModel: StorylineDetailViewModel(
            kind: StorylineKind(
                rawValue: String(localized:StorylineKind.PLAIN_TIMER_STORYLINE_RAW_VALUE)) ?? .plainTimerStoryline(PlainTimerStoryline()
            ),
            completion: {}
        )
    )
}
