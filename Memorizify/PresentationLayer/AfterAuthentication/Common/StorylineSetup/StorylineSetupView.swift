//
//  StorylineSetupView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

import SwiftUI

struct StorylineSetupView: View {
    
    @ObservedObject var viewModel: StorylineSetupViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack() {
            ScrollView {
                Text("Setup new storyline of type: TODO: Switch here based on setup enum and show kind")
                    .bold()
                    .padding()
                VStack {
                    VStack {
                        HStack {
                            Text("Minutes")
                            Spacer()
                            Text("\(Int(viewModel.state.goalMinutes))")
                        }
                        Slider(value: $viewModel.state.goalMinutes, in: StorylineSetupViewModel.goalMinutesRange, step: 1)
                    }
                    .padding()
                    VStack {
                        HStack {
                            Text("Hours")
                            Spacer()
                            Text("\(Int(viewModel.state.goalHours))")
                        }
                        Slider(value: $viewModel.state.goalHours, in: StorylineSetupViewModel.goalHoursRange, step: 1)
                    }
                    .padding()
                }
                .padding()
                
                VStack {
                    VStack {
                        HStack {
                            Text("Study Interval")
                            Spacer()
                            Text("\(Int(viewModel.state.studyInterval))")
                        }
                        Slider(value: $viewModel.state.studyInterval, in: StorylineSetupViewModel.studyIntervalRange, step: 1)
                    }
                    .padding()
                    VStack {
                        HStack {
                            Text("Break Interval")
                            Spacer()
                            Text("\(Int(viewModel.state.breakInterval))")
                        }
                        Slider(value: $viewModel.state.breakInterval, in: StorylineSetupViewModel.breakIntervalRange, step: 1)
                    }
                    .padding()
                }
                .padding()
                
                Spacer()
                if viewModel.state.isButtonLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button("Done") {
                        viewModel.setupStoryline() {
                            presentationMode.wrappedValue.dismiss()
                            router.tab = .home
                        }
                    }
                    .padding()
                }
                Button("Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
    }
}

#Preview {
    StorylineSetupView(viewModel: StorylineSetupViewModel(setup: .create(.testStoryline(TestStoryline())), shouldHomeUpdate: Binding<Bool>(get: { return true }, set: { _ in })))
}
