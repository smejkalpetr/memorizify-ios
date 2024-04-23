//
//  BoardDetailView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import SwiftUI

struct BoardDetailView: View {
    
    @ObservedObject var viewModel: BoardDetailViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            List {
                Section("Board") {
                    VStack {
                        sortMenu
                        listTitleRow
                        listRecords(records: viewModel.state.board.records)
                    }
                }
            }
            .padding()
            .shadow(radius: 5, x: 3.5, y: 3.5)
            .background {
                backgroundImage
            }
            .scrollContentBackground(.hidden)
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
    
    private var sortMenu: some View {
        Menu("Sorting") {
            Button {
                viewModel.state.board.sortByScoreDescending()
            } label: {
                Label("Score Descending", systemImage: "arrow.down.square")
            }
            Button {
                viewModel.state.board.sortByScoreAscending()
            } label: {
                Label("Score Ascending", systemImage: "arrow.up.square")
            }
            Button {
                viewModel.state.board.sortByNicknameDescending()
            } label: {
                Label("Nickname Descending", systemImage: "arrow.down.square")
            }
            Button {
                viewModel.state.board.sortByNicknameAscending()
            } label: {
                Label("Nickname Ascending", systemImage: "arrow.up.square")
            }
        }
        .padding()
    }
    
    private var listTitleRow: some View {
        HStack {
            Text("Nickname")
                .bold()
            Spacer()
            Text("Score")
                .bold()
        }
        .padding()
    }
    
    private func listRecords(records: [BoardRecord]) -> some View {
        ForEach(records) { record in
            HStack {
                Text(record.nickname)
                Spacer()
                Text("\(Int(record.score))")
            }
            .padding()
        }
    }
}

#Preview {
    BoardDetailView(viewModel: BoardDetailViewModel(board: Board(records: [])))
}
