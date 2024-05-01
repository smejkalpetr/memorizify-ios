//
//  PlainTimerStoryline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

/// Represents the storyline data for a plain timer.
struct PlainTimerStoryline: StorylineData {
    
    /// Description of the plain timer storyline.
    let description = ""
    
    /// Short description of the plain timer storyline.
    let shortDescription = ""
    
    /// Pages associated with the plain timer storyline.
    let pages: [StorylinePage] = [PlainTimerStorylinePage()]
    
    /// Number of pages in the plain timer storyline.
    var pageCount: Int { pages.count }
}

/// Represents a page in the plain timer storyline.
struct PlainTimerStorylinePage: StorylinePage {
    let title = String(localized: "Pomodoro Timer")
    let story = ""
}
