//
//  HomeView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack(path: $router.homePath) {
            VStack {
                ScrollView {
                    Text("TODO: Plain Timer")
                        .bold()
                        .padding()
                    if viewModel.state.isStorylinesLoading {
                        ProgressView()
                            .padding()
                    } else if viewModel.state.isInErrorState {
                        Text("Error occured when loading storylines!")
                            .bold()
                            .foregroundStyle(.red)
                    } else if !viewModel.state.storylines.isEmpty {
                        ForEach(viewModel.state.storylines) { storyline in
                            StorylineTileView(viewModel: StorylineTileViewModel(storyline: storyline))
                                .environmentObject(router)
                            
                        }
                    } else {
                        Text("No storylines yet.")
                        Button("Start a new storyline NOW!") {
                            router.tab = .storylines
                        }
                    }
                }
                .refreshable { await viewModel.loadAllStorylines() }
                .onReceive(Notification.Name.refreshStorylines.publisher) { _ in
                    Task { await viewModel.loadAllStorylines() }
                }
            }
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case let .storylineTimer(storyline, page, timer):
                    let vm = StorylineTimerViewModel(storyline: storyline, page: page, timer: timer)
                    StorylineTimerView(viewModel: vm)
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .task {
                if !viewModel.state.hasInitialyLoadedStorylines {
                    await viewModel.loadAllStorylines()
                    viewModel.state.hasInitialyLoadedStorylines = true
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
