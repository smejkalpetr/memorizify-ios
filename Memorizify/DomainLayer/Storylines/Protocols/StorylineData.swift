//
//  StorylineData.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.04.2024.
//

import Foundation

protocol StorylineData {
    var description: String { get }
    var pages: [StorylinePage] { get }
    
    func getCurrentPage(finished: TimeInterval, goal: TimeInterval) throws -> StorylinePage
}

extension StorylineData {
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
