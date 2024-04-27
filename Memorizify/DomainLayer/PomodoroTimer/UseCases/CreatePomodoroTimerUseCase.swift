//
//  CreatePomodoroTimerUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import Foundation

/// Use case for creating a Pomodoro timer.
protocol CreatePomodoroTimerUseCase {
    
    /// Creates a Pomodoro timer with the specified duration.
    /// - Parameter duration: The duration of the Pomodoro timer in minutes.
    /// - Returns: A new instance of PomodoroTimer.
    func execute(duration: TimeInterval) -> PomodoroTimer
}

/// Implementation of the CreatePomodoroTimerUseCase protocol.
struct CreatePomodoroTimerUseCaseImpl: CreatePomodoroTimerUseCase {
    
    /// Initializes the CreatePomodoroTimerUseCaseImpl instance.
    init() {}
    
    /// Creates a Pomodoro timer with the specified duration.
    /// - Parameter duration: The duration of the Pomodoro timer in minutes.
    /// - Returns: A new instance of PomodoroTimer.
    func execute(duration: TimeInterval) -> PomodoroTimer {
        return PomodoroTimer(duration: duration * 60) // Convert minutes to seconds
    }
}
