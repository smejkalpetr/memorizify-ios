//
//  PlainTimerSetupViewModel.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

import SwiftUI

final class PlainTimerSetupViewModel: ObservableObject {
    
    // MARK: Properties
    
    static let studyIntervalRange = 5...60.0
    static let breakIntervalRange = 1...15.0
    
    @Published var state = State()
    
    struct State {
        var studyInterval = 30.0
        var breakInterval = 5.0
    }
}
