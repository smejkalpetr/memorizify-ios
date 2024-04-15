//
//  CreatePomodoroTimerUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import Foundation

protocol CreatePomodoroTimerUseCase {
    func execute(duration: TimeInterval) -> PomodoroTimer
}

struct CreatePomodoroTimerUseCaseImpl: CreatePomodoroTimerUseCase {
    
    init() {}
    
    func execute(duration: TimeInterval) -> PomodoroTimer {
        return PomodoroTimer(duration: duration * 60)
    }
}
