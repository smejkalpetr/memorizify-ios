//
//  StorylineTileView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

import SwiftUI

struct StorylineTileView: View {
    
    @ObservedObject var viewModel: StorylineTileViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    init(viewModel: StorylineTileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button() {
                viewModel.start() { storyline, page, timer in
                    router.homePath.append(HomeRoute.storylineTimer(storyline, page, timer))
                }
            } label: {
                storylineTileLabel
            }
        }
        .listRowInsets(EdgeInsets())
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
        .sheet(item: $viewModel.state.bottomSheetItem) { item in
            StorylineSetupView(viewModel: StorylineSetupViewModel(setup: .update(item)))
                .environmentObject(router)
        }
    }
    
    private var storylineTileLabel: some View {
        ZStack(alignment: .bottomLeading) {
            storylineTileLabelImage
            storylineTileLabelText
        }
        .contextMenu {
            updateContextItem
            deleteContextItem
        }
    }
    
    private var storylineTileLabelImage: some View {
        Image("transparent_placeholder")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
    
    private var storylineTileLabelText: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.state.storyline.kind.rawValue)")
                .font(.title)
                .bold()
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text("\(Int(viewModel.state.storyline.finished))/\(Int(viewModel.state.storyline.goal))".uppercased())
                .font(.caption)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .opacity(0.45)
        }
        .padding()
    }
    
    private var updateContextItem: some View {
        VStack {
            Button() {
                viewModel.state.bottomSheetItem = viewModel.state.storyline
            } label: {
                Label("Update", systemImage: "pencil")
            }
        }
    }
    
    private var deleteContextItem: some View {
        VStack {
            Button(role: .destructive) {
                viewModel.delete()
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
        }
    }
}

#Preview {
    StorylineTileView(
        viewModel: StorylineTileViewModel(
            storyline: Storyline(
                kind: .testStoryline(TestStoryline()),
                goalHours: 0.0,
                goalMinutes: 0.0,
                finished: 0.0,
                studyInterval: 0.0,
                breakInterval: 0.0
            )
        )
    )
}
