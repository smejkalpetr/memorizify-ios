//
//  StorylinesView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct StorylinesView: View {
    
    @ObservedObject var viewModel: StorylinesViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack(path: $router.storylinesPath) {
            VStack {
                storylinesList
            }
            .background {
                backgroundImage
            }
            .navigationDestination(for: StorylinesRoute.self) { route in
                switch route {
                case let .showDetail(kind):
                    StorylineDetailView(viewModel: StorylineDetailViewModel(kind: kind) {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
            .navigationTitle(String(localized: router.tab.rawValue))
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var storylinesList: some View {
        List {
            ForEach(viewModel.state.availableStorylines) { storylineKind in
                Button() {
                    router.storylinesPath.append(StorylinesRoute.showDetail(storylineKind))
                } label: {
                    storylineLabel(name: storylineKind.rawValue, shortDescription: storylineKind.getShortDescription(), kind: storylineKind)
                }
                .listRowInsets(EdgeInsets())
            }
        }
        .padding()
        .shadow(radius: 5, x: 3.5, y: 3.5)
        .listRowSpacing(30)
        .scrollContentBackground(.hidden)
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
    
    private func storylineLabel(name: String, shortDescription: String, kind: StorylineKind) -> some View {
        ZStack(alignment: .bottomLeading) {
            storylineTileLabelImage(kind: kind)
            storylineTileLabelText(name: name, shortDescription: shortDescription)
        }
    }
    
    private func storylineTileLabelImage(kind: StorylineKind) -> some View {
        getStorylineTileLabelImage(kind: kind)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
    
    private func getStorylineTileLabelImage(kind: StorylineKind) -> Image {
        switch kind {
        case .plainTimerStoryline:
            return Image("transparent_placeholder")
        case .draagonStoryline:
            return Image("storyline_dragon")
        case .turtleStoryline:
            return Image("storyline_turtle")
        case .flowerStoryline:
            return Image("storyline_flowers")
        }
    }
    
    private func storylineTileLabelText(name: String, shortDescription: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.title)
                .bold()
                .foregroundStyle(.black)
            Text(shortDescription.uppercased())
                .font(.caption)
                .foregroundStyle(.black)
                .opacity(0.45)
        }
        .padding()
    }
}

#Preview {
    StorylinesView(viewModel: StorylinesViewModel())
}
