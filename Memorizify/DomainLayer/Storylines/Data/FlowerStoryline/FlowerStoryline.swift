//
//  FlowerStoryline.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 01.05.2024.
//

struct FlowerStoryline: StorylineData {
    
    let description = String(localized: """
In the heart of a magical garden, two flowers live side by side: Petal, the gentle vegetarian bloom, and Fang, the carnivorous bud with a taste for meat. Their contrasting diets lead to a series of hilarious and unexpected adventures. As these floral friends explore their unique appetites, they discover that despite their differences, they share common roots. Join Petal and Fang as they navigate the complexities of garden life with humor and a touch of the absurd.
""")
    
    let shortDescription = String(localized: "Bloom and Gloom")
    
    let pages: [StorylinePage] = [
        FlowerStorylinePage1(),
        FlowerStorylinePage2(),
        FlowerStorylinePage3(),
        FlowerStorylinePage4(),
        FlowerStorylinePage5(),
        FlowerStorylinePage6(),
        FlowerStorylinePage7(),
        FlowerStorylinePage8(),
        FlowerStorylinePage9(),
        FlowerStorylinePage10()
    ]
    
    var pageCount: Int { pages.count }
}

struct FlowerStorylinePage1: StorylinePage {
    let title = String(localized: "A Blossoming Friendship")
    let story = String(localized: "In a corner of a vibrant garden, Petal and Fang sprouted just inches apart, one thriving on sunlight and water, the other sneakily eyeing the garden insects.")
}

struct FlowerStorylinePage2: StorylinePage {
    let title = String(localized: "Dietary Differences")
    let story = String(localized: "Petal, ever peaceful, stretched towards the sun, while Fang snapped at passing flies, causing a commotion among the garden dwellers.")
}

struct FlowerStorylinePage3: StorylinePage {
    let title = String(localized: "The Vegetarian's Dilemma")
    let story = String(localized: "Petal tried to convince Fang to try a diet of dew and sunlight, leading to humorous attempts at swapping diets for a day.")
}

struct FlowerStorylinePage4: StorylinePage {
    let title = String(localized: "Unexpected Guests")
    let story = String(localized: "A group of curious bees visited, intrigued by Fang's antics, leaving Petal to host a pollen party to show the beauty of her vegetarian ways.")
}

struct FlowerStorylinePage5: StorylinePage {
    let title = String(localized: "A Thirst for More")
    let story = String(localized: "Fang’s appetite grew, and one day, he tried to sneak a bite of a too-large beetle, ending up with a hilarious headgear of beetle legs.")
}

struct FlowerStorylinePage6: StorylinePage {
    let title = String(localized: "Learning from Laughter")
    let story = String(localized: "The garden erupted in laughter at Fang’s beetle bonnet, and even Fang had to chuckle, seeing his reflection in a dewdrop.")
}

struct FlowerStorylinePage7: StorylinePage {
    let title = String(localized: "The Experiment")
    let story = String(localized: "Petal and Fang decided to experiment with their diets, leading to a mix-up that saw Fang blooming unusually bright, and Petal accidentally trapping a confused ant.")
}

struct FlowerStorylinePage8: StorylinePage {
    let title = String(localized: "Floral Bonds")
    let story = String(localized: "The experiment brought them closer, teaching each the value of the other's lifestyle, and they planned a garden feast that welcomed all creatures.")
}

struct FlowerStorylinePage9: StorylinePage {
    let title = String(localized: "Garden Revelations")
    let story = String(localized: "At the feast, Fang unveiled a surprise dish of plant-based treats that amazed the carnivorous critters, while Petal presented a floral arrangement that dazzled.")
}

struct FlowerStorylinePage10: StorylinePage {
    let title = String(localized: "Unity in Diversity")
    let story = String(localized: "The garden thrived as Petal and Fang, with their unique quirks, proved that diversity is the garden’s true strength, celebrating their differences with every bloom.")
}
