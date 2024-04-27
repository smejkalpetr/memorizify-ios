//
//  SetPomodoroTimerDelegateUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

/// Use case for setting the delegate of a Pomodoro timer.
protocol SetPomodoroTimerDelegateUseCase {
    
    /// Sets the delegate for the specified Pomodoro timer.
    /// - Parameters:
    ///   - delegate: The delegate object conforming to the PomodoroTimerDelegate protocol.
    ///   - timer: The Pomodoro timer to which the delegate will be set.
    func execute(delegate: PomodoroTimerDelegate, for timer: PomodoroTimer)
}

/// Implementation of the SetPomodoroTimerDelegateUseCase protocol.
struct SetPomodoroTimerDelegateUseCaseImpl: SetPomodoroTimerDelegateUseCase {
    
    /// Initializes the SetPomodoroTimerDelegateUseCaseImpl instance.
    init() {}
    
    /// Sets the delegate for the specified Pomodoro timer.
    /// - Parameters:
    ///   - delegate: The delegate object conforming to the PomodoroTimerDelegate protocol.
    ///   - timer: The Pomodoro timer to which the delegate will be set.
    func execute(delegate: PomodoroTimerDelegate, for timer: PomodoroTimer) {
        timer.delegate = delegate
    }
}
