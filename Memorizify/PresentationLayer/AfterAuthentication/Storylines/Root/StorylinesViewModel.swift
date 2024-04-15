//
//  StorylinesViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 09.04.2024.
//

import SwiftUI

final class StorylinesViewModel: ObservableObject {
    
    @Published var state = State()
    
    struct State {
        var bottomSheetItem: StorylineKind?
        let availableStorylines = StorylineKind.allCases
    }
}
