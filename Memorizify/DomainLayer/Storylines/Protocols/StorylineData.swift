//
//  StorylineData.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.04.2024.
//

import Foundation

/// Represents the data associated with a storyline.
protocol StorylineData {
    
    /// A description of the storyline data.
    var description: String { get }
    
    /// The pages associated with the storyline data.
    var pages: [StorylinePage] { get }
    
    /// Retrieves the current page based on the progress of the storyline.
    /// - Parameters:
    ///   - finished: The elapsed time of the storyline.
    ///   - goal: The total goal time of the storyline.
    /// - Returns: The current page of the storyline.
    func getCurrentPage(finished: TimeInterval, goal: TimeInterval) throws -> StorylinePage
}

extension StorylineData {
    
    /// Default implementation of retrieving the current page based on the progress of the storyline.
    /// - Parameters:
    ///   - finished: The elapsed time of the storyline.
    ///   - goal: The total goal time of the storyline.
    /// - Returns: The current page of the storyline.
    func getCurrentPage(finished: TimeInterval, goal: TimeInterval) throws -> StorylinePage {
        let epsilon = 1e-10
        
        // Check whether the finished is not equal to zero
        guard !(abs(finished) < epsilon) else {
            guard let firstPage = self.pages.first else { throw StorylinesError.pageNotFound }
            return firstPage
        }
        
        let ratio = finished / goal
        let pageIndex = Int(ceil(Double(self.pages.count - 1) * ratio))
        
        guard self.pages.indices.contains(pageIndex) else { throw StorylinesError.pageNotFound }
        return self.pages[pageIndex]
    }
}
