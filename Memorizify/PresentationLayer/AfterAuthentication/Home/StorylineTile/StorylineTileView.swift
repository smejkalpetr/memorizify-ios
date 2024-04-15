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
    
    init(viewModel: StorylineTileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Id: \(viewModel.state.storyline.id)")
                Text("Kind: \(viewModel.state.storyline.kind)")
                Text("GoalHours: \(viewModel.state.storyline.goalHours)")
                Text("GoalMinutes: \(viewModel.state.storyline.goalMinutes)")
                Text("Finished: \(viewModel.state.storyline.finished)")
                Text("StudyInterval: \(viewModel.state.storyline.studyInterval)")
                Text("BreakInterval: \(viewModel.state.storyline.breakInterval)")
                HStack {
                    Button("Update") {
                        viewModel.state.bottomSheetItem = viewModel.state.storyline
                    }
                    .padding()
                    Button("Delete") {
                        viewModel.delete()
                    }
                    .padding()
                    Button("Start") {
                        viewModel.start() { storyline, page, timer in
                            router.homePath.append(HomeRoute.storylineTimer(storyline, page, timer))
                        }
                    }
                    .padding()
                }
            }
            .padding()
            .border(.blue)
            .padding()
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
        .sheet(item: $viewModel.state.bottomSheetItem) { item in
            StorylineSetupView(viewModel: StorylineSetupViewModel(setup: .update(item)))
                .environmentObject(router)
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
