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
    
    var body: some View {
        NavigationStack(path: $router.boardPath) {
            VStack {
                ScrollView {
                    VStack {
                        Text("GlobalBoard")
                            .padding()
                        if viewModel.state.isGlobalBoardLoading {
                            ProgressView()
                        } else if let records = viewModel.state.globalBoard?.records {
                            Menu("Sort") {
                                Button {
                                } label: {
                                    Label("Name Ascending", systemImage: "rectangle.stack.badge.plus")
                                }
                                Button {
                                } label: {
                                    Label("Name Descending", systemImage: "folder.badge.plus")
                                }
                                Button {
                                } label: {
                                    Label("Score Ascending", systemImage: "rectangle.stack.badge.person.crop")
                                }
                                Button {
                                } label: {
                                    Label("Score Descending", systemImage: "rectangle.stack.badge.person.crop")
                                }
                            }
                            HStack {
                                Text("Rank")
                                    .padding()
                                Button("Nickname") {
                                    viewModel.changeNicknameSorting()
                                }
                                Spacer()
                                Button("Score") {
                                    viewModel.changeScoreSorting()
                                }
                            }
                            .padding(.horizontal)
                            ForEach(Array(records.prefix(min(5, records.count)).enumerated()), id: \.element.id) { index, record in
                                HStack {
                                    Text("\(index + 1)")
                                        .padding()
                                    Text(record.nickname)
                                    Spacer()
                                    Text("\(record.score)")
                                }
                                .padding(.horizontal)
                            }
                            if records.count > 5 {
                                Button("Show more") {
                                    router.boardPath.append(BoardRoute.showFullGlobalBoard)
                                }
                            }
                        } else {
                            Text("No global records loaded!")
                        }
                    }
                }
                .refreshable { await viewModel.loadGlobalBoard() }
            }
            .navigationDestination(for: BoardRoute.self) { route in
                switch route {
                case .showFullGlobalBoard:
                    if let globalBoard = viewModel.state.globalBoard {
                        GlobalBoardDetailView(
                            viewModel: GlobalBoardDetailViewModel(
                                globalBoard: globalBoard
                            )
                        )
                    }
                }
            }
            .navigationTitle(router.tab.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .task {
                if !viewModel.state.hasInitialyLoadedBoard {
                    await viewModel.loadGlobalBoard()
                }
            }
            .alert(item: Binding<AlertData?>(
                get: { viewModel.state.alert },
                set: { _ in viewModel.dismissAlert() }
            )) { alert in .init(alert) }
        }
    }
}

#Preview {
    BoardView(viewModel: BoardViewModel())
}
