//
//  TestStoryline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.04.2024.
//

struct TestStoryline: StorylineData {
    let pages: [StorylinePage] = [TestStorylinePage1(), TestStorylinePage2(), TestStorylinePage3(), TestStorylinePage4(), TestStorylinePage5()]
    var pageCount: Int { pages.count }
}

struct TestStorylinePage1: StorylinePage {
    let title: String = "Tile page 1"
    let story: String = "Story page 1"
}

struct TestStorylinePage2: StorylinePage {
    let title: String = "Tile page 2"
    let story: String = "Story page 2"
}

struct TestStorylinePage3: StorylinePage {
    let title: String = "Tile page 3"
    let story: String = "Story page 3"
}

struct TestStorylinePage4: StorylinePage {
    let title: String = "Tile page 4"
    let story: String = "Story page 4"
}

struct TestStorylinePage5: StorylinePage {
    let title: String = "Tile page 5"
    let story: String = "Story page 5"
}
