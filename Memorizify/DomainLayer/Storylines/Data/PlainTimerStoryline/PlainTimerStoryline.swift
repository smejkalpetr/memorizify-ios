//
//  PlainTimerStoryline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

struct PlainTimerStoryline: StorylineData {
    let description = ""
    let pages: [StorylinePage] = [PlainTimerStorylinePage()]
    var pageCount: Int { pages.count }
}

struct PlainTimerStorylinePage: StorylinePage {
    let title: String = String(localized: "Pomodoro Timer")
    let story: String = ""
}
