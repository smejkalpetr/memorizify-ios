//
//  DragonStoryline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 29.04.2024.
//

struct DragonStoryline: StorylineData {
    
    let description = String(localized: """
In a kingdom cast in shadow and whispered tales, lives Ember, a dragon cloaked in mystery and feared as a beast of destruction. But beneath the rumors lies a secret, a truth only a lost child will uncover. As the night of the festival draws near, a chance encounter might reveal the gentle heart beneath the fearsome scales. Will the villagers see the protector in their midst, or will old fears blind them to the hero they have in Ember? Unveil the mystery of the dragon who longs to guard, not to destroy.
""")
    
    let shortDescription = String(localized: "From Fear To Guardian")
    
    let pages: [StorylinePage] = [
        DragonStorylinePage2(),
        DragonStorylinePage3(),
        DragonStorylinePage3(),
        DragonStorylinePage4(),
        DragonStorylinePage5(),
        DragonStorylinePage6(),
        DragonStorylinePage7(),
        DragonStorylinePage8(),
        DragonStorylinePage9(),
        DragonStorylinePage10()
    ]
    
    var pageCount: Int { pages.count }
}

struct DragonStorylinePage1: StorylinePage {
    let title = String(localized: "The Misunderstood Guardian")
    let story = String(localized: "In a kingdom shadowed by mountains, a dragon named Ember was rumored to breathe fire of destruction. However, Ember, with his shimmering silver scales, only warmed cold nights for lost travelers.")
}

struct DragonStorylinePage2: StorylinePage {
    let title = String(localized: "The Festival of Fears")
    let story = String(localized: "One evening, as the village prepared for an annual festival, whispers of Ember's terror spread, fearing he would burn the village down. Unknown to them, Ember watched from afar, sad to be misunderstood.")
}

struct DragonStorylinePage3: StorylinePage {
    let title = String(localized: "Lost in the Night")
    let story = String(localized: "During the festival, a child named Lia wandered into the forest, chasing a fluttering lantern. As night fell, her path home grew dark and menacing.")
}

struct DragonStorylinePage4: StorylinePage {
    let title = String(localized: "An Unexpected Guide")
    let story = String(localized: "Hearing soft sobs between the trees, Ember approached Lia carefully, his large eyes glowing gently in the dark. He nudged her back toward the village with his snout, guiding her through the shadows.")
}

struct DragonStorylinePage5: StorylinePage {
    let title = String(localized: "The Return of the Good Dragon")
    let story = String(localized: "Lia, recognizing the dragon's kind intentions, clung to his warm scales. Together, they emerged at the edge of the village, under the watchful eyes of the stunned crowd.")
}

struct DragonStorylinePage6: StorylinePage {
    let title = String(localized: "A New Perspective")
    let story = String(localized: "Murmurs spread as the villagers saw their supposed foe return their lost child. Ember, feeling hopeful, let out a small puff of smoke that glittered like stars, not the flames they feared.")
}

struct DragonStorylinePage7: StorylinePage {
    let title = String(localized: "Lia's Testimony")
    let story = String(localized: "Inspired by Ember's act, Lia spoke to her village about the dragon's true nature. 'He’s not the monster in the mountains; he’s our protector,' she declared with confidence.")
}

struct DragonStorylinePage8: StorylinePage {
    let title = String(localized: "Gifts for the Guardian")
    let story = String(localized: "Gradually, the villagers changed their views. They started leaving gifts of fruits and gems at the edge of the forest, thanking Ember for his silent guardianship.")
}

struct DragonStorylinePage9: StorylinePage {
    let title = String(localized: "Ember's Contributions")
    let story = String(localized: "Ember, now seen in a new light, began to interact more with the villagers. He helped farmers by clearing large rocks and occasionally showered the village with gentle rains for their crops.")
}

struct DragonStorylinePage10: StorylinePage {
    let title = String(localized: "Celebrating the Dragon")
    let story = String(localized: "Over time, Ember wasn't just accepted; he was loved. Festivals now included an extra celebration for the dragon, and Ember, once a feared beast, became the village’s most cherished guardian.")
}
