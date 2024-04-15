//
//  SetPomodoroTimerDelegateUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

protocol SetPomodoroTimerDelegateUseCase {
    func execute(delegate: PomodoroTimerDelegate, for timer: PomodoroTimer)
}

struct SetPomodoroTimerDelegateUseCaseImpl: SetPomodoroTimerDelegateUseCase {
    
    init() {}
    
    func execute(delegate: any PomodoroTimerDelegate, for timer: PomodoroTimer) {
        timer.delegate = delegate
    }
}
