//
//  GlobalBoardDetailView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import SwiftUI

struct GlobalBoardDetailView: View {
    
    @ObservedObject var viewModel: GlobalBoardDetailViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Rank")
                            .padding(.horizontal)
                        Button("Nickname") {
                            viewModel.changeNicknameSorting()
                        }
                        Spacer()
                        Button("Score") {
                            viewModel.changeScoreSorting()
                        }
                    }
                    .padding()
                    ForEach(Array(viewModel.state.globalBoard.records.enumerated()), id: \.element.id) { index, record in
                        HStack {
                            Text("\(index + 1)")
                                .padding()
                            Text(record.nickname)
                            Spacer()
                            Text("\(record.score)")
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    GlobalBoardDetailView(viewModel: GlobalBoardDetailViewModel(globalBoard: Board(records: [])))
}
