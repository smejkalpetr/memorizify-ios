//
//  PomodoroTimer.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 29.03.2024.
//

import Foundation

class PomodoroTimer {
    private var timer: Timer?
    private var startTime: Date?
    private var elapsedTime: TimeInterval = 0
    private var didFinish = false
    private(set) var duration: TimeInterval
    private(set) var state: PomodoroTimerState = .idle
    public var delegate: PomodoroTimerDelegate?
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    var timeElapsed: TimeInterval {
        guard let startTime else { return elapsedTime }
        return elapsedTime + Date().timeIntervalSince(startTime)
    }
    
    var timeRemaining: TimeInterval {
        let remaining = duration - timeElapsed
        return remaining < 0.0 ? 0.0 : remaining
    }
    
    func start() {
        guard state != .running else { return }
        
        startTime = Date()
        
        if state != .paused {
            elapsedTime = 0
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        
        state = .running
    }
    
    func pause() {
        guard state == .running, let startTime else { return }
        
        timer?.invalidate()
        timer = nil
        elapsedTime += Date().timeIntervalSince(startTime)
        state = .paused
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        elapsedTime = 0
        state = .idle
        tick()
    }
    
    func reset(with newDuration: TimeInterval) {
        duration = newDuration
        didFinish = false
    }
    
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
