//
//  StorylinesView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct StorylinesView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: StorylinesViewModel
    
    var body: some View {
        NavigationStack(path: $router.storylinesPath) {
            VStack {
                ScrollView {
                    ForEach(viewModel.state.availableStorylines) { storyline in
                        Button(storyline.rawValue) {
                            viewModel.state.bottomSheetItem = storyline
                        }
                        .padding()
                    }
                }
            }
            .navigationDestination(for: StorylinesRoute.self) { route in
                // switch on router and present a view accordingly
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $viewModel.state.bottomSheetItem) { item in
                StorylineSetupView(viewModel: StorylineSetupViewModel(setup: .create(item)))
                    .environmentObject(router)
            }
        }
    }
}

#Preview {
    StorylinesView(viewModel: StorylinesViewModel())
}
