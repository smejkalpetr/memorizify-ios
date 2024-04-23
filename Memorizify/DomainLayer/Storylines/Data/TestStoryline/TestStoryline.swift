//
//  TestStoryline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.04.2024.
//

struct TestStoryline: StorylineData {
    let description = """
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas aliquet accumsan leo. Nunc dapibus tortor vel mi dapibus sollicitudin. Proin in tellus sit amet nibh dignissim sagittis. Integer malesuada. Curabitur ligula sapien, pulvinar a vestibulum quis, facilisis vel sapien. Phasellus faucibus molestie nisl. Phasellus rhoncus. Pellentesque pretium lectus id turpis. Praesent dapibus. In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero. Phasellus et lorem id felis nonummy placerat. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Pellentesque arcu.
"""
    
    let pages: [StorylinePage] = [TestStorylinePage1(), TestStorylinePage2(), TestStorylinePage3(), TestStorylinePage4(), TestStorylinePage5()]
    var pageCount: Int { pages.count }
}

struct TestStorylinePage1: StorylinePage {
    let title: String = "Tile page 1"
    let story: String = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas aliquet accumsan leo. Nunc dapibus tortor vel mi dapibus sollicitudin. Proin in tellus sit amet nibh dignissim sagittis. Integer malesuada."
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
