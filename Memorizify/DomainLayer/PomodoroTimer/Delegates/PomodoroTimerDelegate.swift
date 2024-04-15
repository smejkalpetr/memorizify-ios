//
//  PomodoroTimerDelegate.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 29.03.2024.
//

protocol PomodoroTimerDelegate {
    func tick(with status: PomodoroTimerStatus)
    func didFinish()
}
