//
//  StorylineTimerView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import SwiftUI
import Foundation

struct StorylineTimerView: View {
    
    @ObservedObject var viewModel: StorylineTimerViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            timerHeader
            Spacer()
            timerBody
            Spacer()
            timerFooter
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 5, x: 3.5, y: 3.5)
        )
        .padding()
        .background {
            backgroundImage
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
        .onFirstAppear {
            viewModel.setDelegate()
            viewModel.start()
        }
        .navigationBarHidden(true)
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_authentication")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var timerHeader: some View {
        VStack {
            storylinePageTitle
            storylinePageStory
        }
        .padding(.vertical)
    }
    
    private var storylinePageTitle: some View {
        Text(viewModel.state.page.title)
            .font(.title)
            .bold()
            .padding()
    }
    
    private var storylinePageStory: some View {
        Text(viewModel.state.page.story)
            .multilineTextAlignment(.center)
            .foregroundStyle(colorScheme == .dark ? Color(.white).opacity(0.8) : Color(.black).opacity(0.6))
            .padding()
    }
    
    private var timerBody: some View {
        VStack {
            if let transition = viewModel.state.transition {
                transitionText(transition: transition)
            } else if viewModel.state.storyline.isFinished {
                storylineFinishedText
            } else if viewModel.state.isDone {
                doneState
            } else if viewModel.state.isLoading {
                ProgressView()
            } else {
                countdownTimer
            }
        }
        .padding()
    }
    
    private func transitionText(transition: LocalizedStringResource) -> some View {
        Text(transition)
            .font(.title)
            .bold()
            .multilineTextAlignment(.center)
    }
    
    private var storylineFinishedText: some View {
        Text("Storyline finished!")
            .font(.title)
            .bold()
    }
    
    private var doneState: some View {
        VStack {
            Text("Done!")
                .font(.title)
                .bold()
                .padding()
            Button("Repeat") {
                viewModel.repeatTimer()
            }
            .bold()
            .foregroundStyle(.blue)
        }
    }
    
    private var countdownTimer: some View {
        Text(viewModel.state.countdown)
            .font(.title2)
            .bold()
    }
    
    private var timerFooter: some View {
        VStack {
            pauseResumeButton
            cancelButton
        }
        .padding()
    }
    
    private var pauseResumeButton: some View {
        Button(viewModel.state.isPaused ? "Resume" : "Pause") {
            viewModel.state.isPaused ? viewModel.resume() : viewModel.pause()
        }
        .foregroundStyle(.blue)
        .disabled(viewModel.state.isDone)
        .bold()
        .padding()
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
        .foregroundStyle(.red)
        .padding()
    }
}

#Preview {
    StorylineTimerView(viewModel: 
        StorylineTimerViewModel(
            storyline: Storyline(
                kind: .plainTimerStoryline(PlainTimerStoryline()),
                goalHours: 0.0,
                goalMinutes: 0.0,
                finished: 0.0,
                studyInterval: 0.0,
                breakInterval: 0.0
            ),
            page: PlainTimerStorylinePage(),
            timer: PomodoroTimer(duration: 60.0),
            timerKind: .storyline
        )
    )
}
