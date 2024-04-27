//
//  PomodoroTimerStatus.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.04.2024.
//

import Foundation

/// Represents the status of a Pomodoro timer.
struct PomodoroTimerStatus {
    
    /// The time elapsed since the timer started.
    let timeElapsed: TimeInterval
    
    /// The time remaining until the timer finishes.
    let timeRemaining: TimeInterval
    
    /// The current state of the timer.
    let state: PomodoroTimerState
}
