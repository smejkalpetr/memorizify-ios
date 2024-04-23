//
//  StorylineDetailViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.04.2024.
//

import SwiftUI

final class StorylineDetailViewModel: ObservableObject {
    
    private let completion: () -> ()
    
    @Published var state: State
    
    init(kind: StorylineKind, completion: @escaping () -> ()) {
        self.completion = completion
        self.state = State(kind: kind)
    }

    struct State {
        let kind: StorylineKind
        var bottomSheetItem: StorylineKind?
        
        init(kind: StorylineKind) {
            self.kind = kind
        }
    }
}
