//
//  HomeView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack(path: $router.homePath) {
            VStack {
                List {
                    plainTimer
                    myStorylines
                }
                .padding()
                .shadow(radius: 5, x: 3.5, y: 3.5)
                .listRowSpacing(25)
                .background {
                    backgroundImage
                }
                .scrollContentBackground(.hidden)
                .refreshable { viewModel.loadAllStorylines() }
                .onReceive(Notification.Name.refreshStorylines.publisher) { _ in
                    Task { viewModel.loadAllStorylines() }
                }
            }
            .alert(item: Binding<AlertData?>(
                get: { viewModel.state.alert },
                set: { _ in viewModel.dismissAlert() }
            )) { alert in .init(alert) }
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case let .plainTimer(studyInterval, breakInterval):
                    StorylineTimerView(
                        viewModel: StorylineTimerViewModel(
                            storyline: Storyline(
                                kind: StorylineKind(
                                    rawValue: StorylineKind
                                        .PLAIN_TIMER_STORYLINE_RAW_VALUE) ??
                                        .plainTimerStoryline(PlainTimerStoryline()
                                ),
                                goalHours: .infinity,
                                goalMinutes: .infinity,
                                finished: 0.0,
                                studyInterval: studyInterval,
                                breakInterval: breakInterval
                            ),
                            page: PlainTimerStorylinePage(),
                            timer: PomodoroTimer(duration: studyInterval * 60),
                            timerKind: .plain
                        )
                    )
                case let .storylineTimer(storyline, page, timer):
                    let vm = StorylineTimerViewModel(storyline: storyline, page: page, timer: timer, timerKind: .storyline)
                    StorylineTimerView(viewModel: vm)
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .onFirstAppear {
                viewModel.loadAllStorylines()
            }
            .sheet(isPresented: $viewModel.state.isPlainTimerBottomSheetPresented) {
                PlainTimerSetupView(viewModel: PlainTimerSetupViewModel())
            }
        }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("background_home")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var plainTimer: some View {
        Section("Plain Timer") {
            Button() {
                viewModel.state.isPlainTimerBottomSheetPresented = true
            } label: {
                ZStack(alignment: .bottomLeading) {
                    plainTimerImage
                    plainTimerText
                }
                .listRowInsets(EdgeInsets())
            }
            .buttonStyle(.plain)
        }
    }
    
    private var plainTimerImage: some View {
        Image("plain_timer_alarm")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
    
    private var plainTimerText: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text("Plain Timer")
                .font(.title)
                .bold()
            Text(String(localized: "Tap to start a classic pomodoro timer.").uppercased())
                .font(.caption)
                .opacity(0.45)
        }
        .padding()
    }
    
    private var myStorylines: some View {
        Section("My storylines") {
            if viewModel.state.isStorylinesLoading {
                myStorylinesLoading
            } else if viewModel.state.isInErrorState {
                myStorylinesError
            } else if viewModel.state.storylines.isEmpty {
                myStorylinesEmpty
            } else {
                myStorylinesContent
            }
        }
    }
    
    private var myStorylinesLoading: some View {
        ForEach(0..<3) { _ in
            ZStack(alignment: .bottomLeading) {
                myStorylinesLoadingImage
                myStorylinesLoadingText
            }
            .listRowInsets(EdgeInsets())
            .animatePlaceholder(isLoading: $viewModel.state.isStorylinesLoading)
        }
    }
    
    private var myStorylinesLoadingImage: some View {
        ZStack(alignment: .bottomLeading) {
            Image("transparent_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            Color.white.opacity(0.6)
        }
    }
    
    private var myStorylinesLoadingText: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 100, height: 25)
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.35))
                    .frame(width: 150, height: 20)
                    .padding([.horizontal, .bottom])
                Spacer()
            }
        }
    }
    
    private var myStorylinesError: some View {
        VStack {
            HStack {
                Spacer()
                Text("Oops! Failed to load the storylines :(")
                    .bold()
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .padding()
    }
    
    private var myStorylinesContent: some View {
        ForEach(viewModel.state.storylines) { storyline in
            StorylineTileView(viewModel: StorylineTileViewModel(storyline: storyline))
                .environmentObject(router)
        }
    }
    
    private var myStorylinesEmpty: some View {
        ZStack {
            myStorylinesEmptyImage
            Button() {
                router.tab = .storylines
            } label: {
                myStorylinesEmptyText
            }
        }
        .listRowInsets(EdgeInsets())
    }
    
    private var myStorylinesEmptyImage: some View {
        ZStack(alignment: .bottomLeading) {
            Image("transparent_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            Color.gray.opacity(0.6)
        }
    }
    
    private var myStorylinesEmptyText: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("No storylines yet")
                .font(.title3)
                .bold()
                .shadow(radius: 2)
                .foregroundColor(.white)
            Text("Start a new storyline NOW!")
                .font(.callout)
                .bold()
                .shadow(radius: 3)
                .foregroundColor(.white)
            Spacer()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
