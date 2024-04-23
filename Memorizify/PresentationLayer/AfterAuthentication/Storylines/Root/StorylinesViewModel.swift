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
        let availableStorylines = StorylineKind.allCases
    }
}
