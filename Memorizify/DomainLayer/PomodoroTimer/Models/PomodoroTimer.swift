//
//  PomodoroTimer.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 29.03.2024.
//

import Foundation
import Resolver

/// Timer for Pomodoro technique.
class PomodoroTimer {
    
    // MARK: Properties
    
    /// The timer instance.
    private var timer: Timer?
    
    /// The start time of the timer.
    private var startTime: Date?
    
    /// The elapsed time since the timer started.
    private var elapsedTime: TimeInterval = 0
    
    /// Flag indicating whether the timer has finished.
    private var didFinish = false
    
    /// The duration of the timer.
    private(set) var duration: TimeInterval
    
    /// The current state of the timer.
    private(set) var state: PomodoroTimerState = .idle
    
    /// The delegate for receiving timer events.
    public var delegate: PomodoroTimerDelegate?
    
    /// The local notification instance for timer notifications.
    private var localNotification: LocalNotification?
    
    /// Injected dependency for scheduling local notifications.
    @Injected private var scheduleLocalNotificationUseCase: ScheduleLocalNotificationUseCase
    
    /// Injected dependency for canceling local notifications.
    @Injected private var cancelLocalNotificationUseCase: CancelLocalNotificationUseCase
    
    // MARK: Initialization
    
    /// Initializes the PomodoroTimer with the specified duration.
    /// - Parameter duration: The duration of the timer.
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    // MARK: Computed properties
    
    /// The total time elapsed since the timer started.
    var timeElapsed: TimeInterval {
        guard let startTime else { return elapsedTime }
        return elapsedTime + Date().timeIntervalSince(startTime)
    }
    
    /// The remaining time until the timer finishes.
    var timeRemaining: TimeInterval {
        let remaining = duration - timeElapsed
        return remaining < 0.0 ? 0.0 : remaining
    }
    
    // MARK: Public methods
    
    /// Starts the timer.
    func start() {
        guard state != .running else { return }
        
        startTime = Date()
        
        if state != .paused {
            elapsedTime = 0
        }
        
        // Schedule local notification
        localNotification = scheduleLocalNotificationUseCase.execute(
            LocalNotification(
                title: "Timer Finished",
                message: "Your Pomodoro Timer has just finished. Open Memorizify to see your progress!"
            ),
            timeInterval: duration - 3
        )
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        
        state = .running
    }
    
    /// Pauses the timer.
    func pause() {
        guard state == .running, let startTime else { return }
        
        timer?.invalidate()
        timer = nil
        elapsedTime += Date().timeIntervalSince(startTime)
        state = .paused
    }
    
    /// Stops the timer.
    func stop() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        elapsedTime = 0
        state = .idle
        tick()
        
        if let localNotification, let identifier = localNotification.identifier {
            cancelLocalNotificationUseCase.execute(identifier: identifier)
        }
    }
    
    /// Resets the timer with a new duration.
    /// - Parameter newDuration: The new duration of the timer.
    func reset(with newDuration: TimeInterval) {
        duration = newDuration
        didFinish = false
    }
    
    // MARK: Private methods
    
    /// Performs actions for each timer tick.
    private func tick() {
        delegate?.tick(with: PomodoroTimerStatus(timeElapsed: timeElapsed, timeRemaining: timeRemaining, state: state))
        
        if abs(timeRemaining) < 10e-9  {
            if !didFinish {
                delegate?.didFinish()
                didFinish = true
            }
        }
    }
}
