//
//  PomodoroTimerStatus.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.04.2024.
//

import Foundation

struct PomodoroTimerStatus {
    let timeElapsed: TimeInterval
    let timeRemaining: TimeInterval
    let state: PomodoroTimerState
}
