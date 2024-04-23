//
//  BoardView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 22.03.2024.
//

import SwiftUI

struct BoardView: View {
    
    @ObservedObject var viewModel: BoardViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack(path: $router.boardPath) {
            VStack {
                List {
                    Section("Top 10") {
                        if viewModel.state.isBoardLoading {
                            boardLoading
                        } else if let records = viewModel.state.board?.records {
                            boardLoaded(records: records)
                        } else {
                            boardNotLoaded
                        }
                    }
                }
                .padding()
                .shadow(radius: 5, x: 3.5, y: 3.5)
                .background {
                    backgroundImage
                }
                .scrollContentBackground(.hidden)
                .refreshable { await viewModel.loadBoard() }
            }
            .navigationDestination(for: BoardRoute.self) { route in
                switch route {
                case .showFullBoard:
                    if let board = viewModel.state.board {
                        BoardDetailView(
                            viewModel: BoardDetailViewModel(
                                board: board
                            )
                        )
                    }
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .task {
                if !viewModel.state.hasInitialyLoadedBoard {
                    await viewModel.loadBoard()
                }
            }
            .alert(item: Binding<AlertData?>(
                get: { viewModel.state.alert },
                set: { _ in viewModel.dismissAlert() }
            )) { alert in .init(alert) }
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
    
    private var boardLoading: some View {
        ForEach(0..<3) { _ in
            ZStack(alignment: .bottomLeading) {
                boardLoadingImage
                boardLoadingText
                if colorScheme == .dark {
                    Color.black.opacity(0.5)
                }
            }
            .listRowInsets(EdgeInsets())
            .animatePlaceholder(isLoading: $viewModel.state.isBoardLoading)
        }
    }
    
    private var boardLoadingImage: some View {
        ZStack(alignment: .bottomLeading) {
            Image("storyline_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            Color.white.opacity(0.6)
        }
    }
    
    private var boardLoadingText: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.35))
                    .frame(height: 32)
                    .padding([.horizontal])
            }
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.35))
                    .frame(height: 32)
                    .padding([.horizontal])
            }
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 32)
                    .padding(.horizontal)
            }
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.35))
                    .frame(height: 32)
                    .padding([.horizontal, .bottom])
            }
        }
    }
    
    
    private func boardLoaded(records: [BoardRecord]) -> some View {
        VStack {
            listTitleRow
            listRecords(records: records)
            showMoreRow(records: records)
        }
    }
    
    private var listTitleRow: some View {
        HStack {
            Text("Rank")
                .bold()
                .padding([.vertical, .trailing])
            Text("Nickname")
                .bold()
            Spacer()
            Text("Score")
                .bold()
        }
    }
    
    private func listRecords(records: [BoardRecord]) -> some View {
        ForEach(Array(records.prefix(min(10, records.count)).enumerated()), id: \.element.id) { index, record in
            HStack {
                Text("\(index + 1)")
                    .padding([.vertical, .trailing])
                Text(record.nickname)
                if index == 0 {
                    Text("🥇")
                } else if index == 1 {
                    Text("🥈")
                } else if index == 2 {
                    Text("🥉")
                }
                Spacer()
                Text("\(Int(record.score))")
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func showMoreRow(records: [BoardRecord]) -> some View {
        if records.count > 10 {
            VStack {
                Button("Show more") {
                    router.boardPath.append(BoardRoute.showFullBoard)
                }
            }
            .padding()
        }
    }
    
    private var boardNotLoaded: some View {
        Text("No records loaded!")
    }
}

#Preview {
    BoardView(viewModel: BoardViewModel())
}
