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
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var storylinesList: some View {
        List {
            #warning("FIXME: Remove next line when there are more available storylines!")
            ForEach(0..<3) { _ in
                ForEach(viewModel.state.availableStorylines) { storylineKind in
                    Button() {
                        router.storylinesPath.append(StorylinesRoute.showDetail(storylineKind))
                    } label: {
                        storylineLabel(name: storylineKind.rawValue)
                    }
                    .listRowInsets(EdgeInsets())
                }
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
    
    private func storylineLabel(name: String) -> some View {
        ZStack(alignment: .bottomLeading) {
            storylineTileLabelImage
            storylineTileLabelText(name: name)
        }
    }
    
    private var storylineTileLabelImage: some View {
        Image("transparent_placeholder")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
    
    private func storylineTileLabelText(name: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.title)
                .bold()
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text("the other text".uppercased())
                .font(.caption)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .opacity(0.45)
        }
        .padding()
    }
}

#Preview {
    StorylinesView(viewModel: StorylinesViewModel())
}
