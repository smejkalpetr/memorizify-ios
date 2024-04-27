//
//  PomodoroTimerDelegate.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 29.03.2024.
//

/// Delegate protocol for Pomodoro timer events.
protocol PomodoroTimerDelegate {
    
    /// Notifies the delegate about the timer tick event.
    /// - Parameter status: The current status of the Pomodoro timer.
    func tick(with status: PomodoroTimerStatus)
    
    /// Notifies the delegate that the Pomodoro timer has finished.
    func didFinish()
}
