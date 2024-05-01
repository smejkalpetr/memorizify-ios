//
//  TurtleStoryline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.05.2024.
//

struct TurtleStoryline: StorylineData {
    
    let description = String(localized: """
In a bustling coastal reef, Tilly the turtle becomes an accidental celebrity when a plastic bottle top gets stuck in her nose. As the undersea community watches in a mix of horror and amusement, Tilly’s plight becomes a bizarre spectacle. But beneath the laughs lies a call to action, a reminder of the ocean’s fragility and our role in its fate. Will the marine inhabitants see the message behind the mishap, or will Tilly's predicament be lost in a sea of memes? Dive into the tale of the turtle who turned trash into a treasure of awareness.
""")
    
    let shortDescription = String(localized: "From Trash to Treasure")
    
    let pages: [StorylinePage] = [
        TurtleStorylinePage1(),
        TurtleStorylinePage2(),
        TurtleStorylinePage3(),
        TurtleStorylinePage4(),
        TurtleStorylinePage5(),
        TurtleStorylinePage6(),
        TurtleStorylinePage7(),
        TurtleStorylinePage8(),
        TurtleStorylinePage9(),
        TurtleStorylinePage10()
    ]
    
    var pageCount: Int { pages.count }
}

struct TurtleStorylinePage1: StorylinePage {
    let title = String(localized: "The Unintended Ornament")
    let story = String(localized: "Tilly the turtle was happily swimming through her reef when a plastic bottle top, a remnant of human carelessness, lodged itself comically in her nose.")
}

struct TurtleStorylinePage2: StorylinePage {
    let title = String(localized: "Viral Sensation")
    let story = String(localized: "Overnight, Tilly became an internet sensation as divers captured her predicament, turning her into a meme across social networks.")
}

struct TurtleStorylinePage3: StorylinePage {
    let title = String(localized: "Misunderstood Decorations")
    let story = String(localized: "While Tilly dealt with her unwelcome accessory, other sea creatures started sporting garbage accessories in a misguided attempt at fashion.")
}

struct TurtleStorylinePage4: StorylinePage {
    let title = String(localized: "An Awkward Intervention")
    let story = String(localized: "A well-meaning octopus tried to remove the bottle top, resulting in a slapstick series of failed attempts that only added to Tilly's internet fame.")
}

struct TurtleStorylinePage5: StorylinePage {
    let title = String(localized: "A Dive into Fame")
    let story = String(localized: "As Tilly's story spread, more divers visited the reef, hoping to snap a picture with the famous 'nose-jewel' turtle.")
}

struct TurtleStorylinePage6: StorylinePage {
    let title = String(localized: "The Message Emerges")
    let story = String(localized: "Gradually, the humor faded and a serious message about pollution began to resonate with Tilly’s growing audience.")
}

struct TurtleStorylinePage7: StorylinePage {
    let title = String(localized: "Sea Change")
    let story = String(localized: "Inspired by Tilly, a group of young environmentalists started a campaign to clean up ocean waste, using her image as the campaign face.")
}

struct TurtleStorylinePage8: StorylinePage {
    let title = String(localized: "Gifts of Gratitude")
    let story = String(localized: "The local sea creatures, realizing the impact of their actions, began offering gifts of natural beauty to Tilly, like coral pieces and colorful stones.")
}

struct TurtleStorylinePage9: StorylinePage {
    let title = String(localized: "Tilly's Contributions")
    let story = String(localized: "With her newfound fame, Tilly helped spread awareness by leading divers on tours of her reef, showing the beauty worth saving.")
}

struct TurtleStorylinePage10: StorylinePage {
    let title = String(localized: "Celebrating the Turtle")
    let story = String(localized: "Tilly, once a comedic meme, became a symbol of resilience and a beloved figure in the fight against ocean pollution.")
}

