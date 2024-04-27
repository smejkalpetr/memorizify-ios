//
//  Phase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

/// Represents the phase of a Pomodoro timer, either study or break.
enum Phase {
    case study
    case `break`
    
    /// Toggles the phase of the Pomodoro timer between study and break.
    mutating func toggle() {
        switch self {
        case .study:
            self = .break
        case .break:
            self = .study
        }
    }
}
