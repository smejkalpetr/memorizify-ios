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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                storylineSettings
            }
            Spacer()
            footerButtons
        }
        .background {
            backgroundImage
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.dismissAlert() }
        )) { alert in .init(alert) }
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
    
    private var storylineSettings: some View {
        VStack {
            sliders
        }
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 5, x: 3.5, y: 3.5)
        )
        .padding()
    }
    
    private var sliders: some View {
        VStack {
            VStack {
                sliderGroupTitle("Storyline goal")
                SliderView(title: "Hours", range: StorylineSetupViewModel.goalHoursRange, valueBinding: $viewModel.state.goalHours)
                SliderView(title: "Minutes", range: StorylineSetupViewModel.goalMinutesRange, valueBinding: $viewModel.state.goalMinutes)
            }
            .padding(.bottom)
            VStack {
                sliderGroupTitle("Timer parameters")
                SliderView(title: "Study Interval", range: StorylineSetupViewModel.studyIntervalRange, valueBinding: $viewModel.state.studyInterval)
                SliderView(title: "Break Interval", range: StorylineSetupViewModel.breakIntervalRange, valueBinding: $viewModel.state.breakInterval)
            }
            .padding(.top)
        }
        .padding()
    }
    
    private func sliderGroupTitle(_ title: String) -> some View {
        VStack {
            HStack {
                Text(title.uppercased())
                    .font(.callout)
                    .foregroundStyle(colorScheme == .dark ? .white.opacity(0.6) : .gray)
                Spacer()
            }
            Divider()
        }
        .padding(.bottom)
    }
    
    private var footerButtons: some View {
        VStack {
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
                .buttonStyle(PrimaryButtonStyle())
            }
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
}

#Preview {
    StorylineSetupView(viewModel: StorylineSetupViewModel(setup: .create(.testStoryline(TestStoryline()))))
}
