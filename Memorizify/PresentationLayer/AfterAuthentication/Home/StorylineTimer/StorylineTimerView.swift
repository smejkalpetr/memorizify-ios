//
//  StorylineTimerView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import SwiftUI

struct StorylineTimerView: View {
    
    @ObservedObject var viewModel: StorylineTimerViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text(viewModel.state.page.title)
                .padding()
            Text(viewModel.state.page.story)
                .padding()
            Spacer()
            if let transition = viewModel.state.transition {
                Text(transition)
                    .font(.largeTitle)
                    .bold()
            } else if viewModel.state.storyline.isFinished {
                Text("Storyline finished!")
                    .font(.largeTitle)
                    .bold()
            } else if viewModel.state.isDone {
                HStack {
                    Text("Done!")
                        .font(.largeTitle)
                        .bold()
                    Button("Repeat") {
                        viewModel.repeatTimer()
                    }
                }
            } else if viewModel.state.isLoading {
                ProgressView()
            } else {
                Text(viewModel.state.countdown)
                    .font(.largeTitle)
                    .bold()
            }
            Spacer()
            Button(viewModel.state.isPaused ? "Resume" : "Pause") {
                viewModel.state.isPaused ? viewModel.resume() : viewModel.pause()
            }
            .disabled(viewModel.state.isDone)
            .padding()
            Button("Cancel") {
               presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .padding()
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
        .onAppear {
            viewModel.setDelegate()
            viewModel.start()
        }
        .onDisappear {
            viewModel.cancel()
        }
    }
}

#Preview {
    StorylineTimerView(viewModel: 
        StorylineTimerViewModel(
            storyline: Storyline(
                kind: .testStoryline(TestStoryline()),
                goalHours: 0.0, 
                goalMinutes: 0.0,
                finished: 0.0,
                studyInterval: 0.0,
                breakInterval: 0.0
            ),
            page: TestStorylinePage1(),
            timer: PomodoroTimer(duration: 60.0)
        )
    )
}
