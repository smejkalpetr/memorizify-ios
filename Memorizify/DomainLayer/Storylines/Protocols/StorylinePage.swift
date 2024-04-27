//
//  StorylinePage.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.04.2024.
//

/// Represents a page within a storyline.
protocol StorylinePage {
    
    /// The title of the storyline page.
    var title: String { get }
    
    /// The content or story of the storyline page.
    var story: String { get }
}
