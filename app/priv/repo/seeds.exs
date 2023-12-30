# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias App.Repo
alias App.Avatars.Avatar
alias App.Quiz.{Story, Question, Answer}

%Avatar{
  id: 1,
  image: "/images/astronaut.png",
  rarity: "common"
}
|> Repo.insert!()

%Avatar{
  id: 2,
  image: "/images/alien.png",
  rarity: "common"
}
|> Repo.insert!()

%Avatar{
  id: 3,
  image: "/images/astrodog.png",
  rarity: "uncommon"
}
|> Repo.insert!()

%Avatar{
  id: 4,
  image: "/images/asteroid.png",
  rarity: "epic"
}
|> Repo.insert!()

## 'easy' stories
%Story{
  id: 1,
  difficulty: "easy",
  content: "In a coastal town, a friendly family of pelicans lived near the shimmering shore. Papa Pelican, Mama Pelican, and their three fluffy chicks spent their days soaring through the sky and diving into the ocean to catch delicious fish. One day, the pelican family organized a friendly fishing competition to see who could catch the most fish. The fluffy chicks, with their clumsy yet adorable attempts, made everyone laugh as they learned the art of fishing from their wise parents."
}
|> Repo.insert!()

          %Question{
            id: 1,
            story_id: 1,
            content: "What did the pelicans organize one day?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 1,
                      content: "A flying contest",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 1,
                      content: "A fishing competition",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 1,
                      content: "A swimming race",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 1,
                      content: "A sandcastle building contest",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 2,
            story_id: 1,
            content: "What did the fluffy chicks learn from their parents?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 2,
                      content: "How to build sandcastles",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 2,
                      content: "Flying tricks",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 2,
                      content: "Singing melodies",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 2,
                      content: "The art of fishing",
                      is_correct: true
                    }
                    |> Repo.insert!()

          %Question{
            id: 3,
            story_id: 1,
            content: "Where did the pelican family live?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 3,
                      content: "Near the shimmering shore",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 3,
                      content: "In a mountain cave",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 3,
                      content: "Deep in the forest",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 3,
                      content: "On top of a skyscraper",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 4,
            story_id: 1,
            content: "How did the pelicans spend their days?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 4,
                      content: "Building sandcastles on the beach",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 4,
                      content: "Soaring through the sky and diving into the ocean to catch fish",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 4,
                      content: "Climbing tall mountains",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 4,
                      content: "Exploring dark caves",
                      is_correct: false
                    }
                    |> Repo.insert!()

%Story{
  id: 2,
  difficulty: "easy",
  content: "In a cozy town, the Johnson family eagerly prepared for Thanksgiving. Mom baked a golden turkey, and the aroma filled the air. Dad decorated the table with vibrant autumn colors, and the children crafted handmade decorations. As they gathered around to feast, they took turns expressing gratitude. Each family member shared what they were thankful for, creating a heartwarming atmosphere of love and appreciation."
}
|> Repo.insert!()

          %Question{
            id: 5,
            story_id: 2,
            content: "What did Mom bake for Thanksgiving?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 5,
                      content: "Pumpkin pie",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 5,
                      content: "Chocolate cake",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 5,
                      content: "A golden turkey",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 5,
                      content: "Apple pie",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 6,
            story_id: 2,
            content: "What did Dad decorate the table with?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 6,
                      content: "Bright summer shades",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 6,
                      content: "Cool winter tones",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 6,
                      content: "Vibrant autumn colors",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 6,
                      content: "Pastel spring colors",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 7,
            story_id: 2,
            content: "What did the children craft for Thanksgiving?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 7,
                      content: "Handmade decorations",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 7,
                      content: "Store-bought toys",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 7,
                      content: "Electronic gadgets",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 7,
                      content: "Artificial flowers",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 8,
            story_id: 2,
            content: "What atmosphere did the family create during Thanksgiving?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 8,
                      content: "A spooky Halloween atmosphere",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 8,
                      content: "A lively party atmosphere",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 8,
                      content: "A quiet and somber atmosphere",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 8,
                      content: "A heartwarming atmosphere of love and appreciation",
                      is_correct: true
                    }
                    |> Repo.insert!()

%Story{
  id: 3,
  difficulty: "easy",
  content: "In the heart of the town, there was a lively park where families gathered for fun. Children swung on swings, parents enjoyed picnics on checkered blankets, and friends played a spirited game of frisbee. The laughter of kids echoed as they took turns on the colorful carousel, and the ice cream truck's jingle added a sweet melody to the cheerful atmosphere."
}
|> Repo.insert!()

          %Question{
            id: 9,
            story_id: 3,
            content: "What did children do on the swings in the park?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 9,
                      content: "Swung",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 9,
                      content: "Jumped rope",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 9,
                      content: "Skipped",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 9,
                      content: "Climbed trees",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 10,
            story_id: 3,
            content: "What added a sweet melody to the cheerful atmosphere in the park?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 10,
                      content: "Children singing",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 10,
                      content: "The ice cream truck's jingle",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 10,
                      content: "Birdsong",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 10,
                      content: "The sound of a fountain",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 11,
            story_id: 3,
            content: "What did parents enjoy on checkered blankets in the park?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 11,
                      content: "Reading books",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 11,
                      content: "Flying kites",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 11,
                      content: "Playing music",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 11,
                      content: "Picnics",
                      is_correct: true
                    }
                    |> Repo.insert!()

          %Question{
            id: 12,
            story_id: 3,
            content: "What game did friends play in the park?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 12,
                      content: "Frisbee",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 12,
                      content: "Hide and seek",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 12,
                      content: "Soccer",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 12,
                      content: "Basketball",
                      is_correct: false
                    }
                    |> Repo.insert!()

## 'medium' stories
%Story{
  id: 4,
  difficulty: "medium",
  content: "On a sunny day, a lively boy named Tommy and his energetic dog, Max, decided to play fetch in the neighborhood park. Tommy grabbed a bright red ball and gave it a mighty throw. Max, with his wagging tail and eager eyes, sprinted joyfully, retrieving the ball with enthusiasm. The two friends continued their game, laughing and enjoying the simple pleasure of companionship under the warm sun."
}
|> Repo.insert!()

          %Question{
            id: 13,
            story_id: 4,
            content: "What did Tommy and Max decide to play in the park?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 13,
                      content: "Hide and seek",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 13,
                      content: "Soccer",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 13,
                      content: "Fetch",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 13,
                      content: "Hockey",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 14,
            story_id: 4,
            content: "What color was the ball that Tommy threw?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 14,
                      content: "Forest green",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 14,
                      content: "Bright red",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 14,
                      content: "Sunshine yellow",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 14,
                      content: "Deep blue",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 15,
            story_id: 4,
            content: "What did Max do when Tommy threw the ball?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 15,
                      content: "Climbed a tree",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 15,
                      content: "Sprinted joyfully, retrieving the ball with enthusiasm",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 15,
                      content: "Barked at other dogs",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 15,
                      content: "Rolled in the grass",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 16,
            story_id: 4,
            content: "What did Tommy and Max enjoy under the warm sun?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 16,
                      content: "Building sandcastles",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 16,
                      content: "Eating ice cream",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 16,
                      content: "The simple pleasure of companionship",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 16,
                      content: "Riding bicycles",
                      is_correct: false
                    }
                    |> Repo.insert!()

%Story{
  id: 5,
  difficulty: "medium",
  content: "In the icy expanse of Antarctica, an intrepid explorer named Alex embarked on a daring journey. Equipped with warm gear, Alex trekked across the snow-covered landscape, encountering vast glaciers and stunning ice formations. As the days went by, Alex marveled at the incredible wildlife, from penguins waddling along the coast to seals basking on the ice. The explorer faced challenges like icy winds and freezing temperatures but pressed on, driven by the thrill of discovery and the desire to unveil the secrets of this frozen wonderland."
}
|> Repo.insert!()

          %Question{
            id: 17,
            story_id: 5,
            content: "What did Alex encounter while trekking across Antarctica?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 17,
                      content: "Vast glaciers and stunning ice formations",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 17,
                      content: "Sandy deserts",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 17,
                      content: "Tropical rainforests",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 17,
                      content: "Volcanic mountains",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 18,
            story_id: 5,
            content: "What wildlife did Alex encounter in Antarctica?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 18,
                      content: "Penguins waddling along the coast and seals basking on the ice",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 18,
                      content: "Cheetahs and giraffes",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 18,
                      content: "Eagles and bears",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 18,
                      content: "Dolphins and whales",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 19,
            story_id: 5,
            content: "What was the weather like in Antarctica?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 19,
                      content: "Warm breezes and mild temperatures",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 19,
                      content: "Sunny weather and clear skies",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 19,
                      content: "Thunderstorms and heavy rain",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 19,
                      content: "Icy winds and freezing temperatures",
                      is_correct: true
                    }
                    |> Repo.insert!()

          %Question{
            id: 20,
            story_id: 5,
            content: "What drove the explorer to continue the journey in Antarctica?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 20,
                      content: "The hope of finding buried treasure",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 20,
                      content: "The thrill of discovery and the desire to unveil the secrets of the frozen wonderland",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 20,
                      content: "The quest for the perfect picnic spot",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 20,
                      content: "The dream of building a snowman",
                      is_correct: false
                    }
                    |> Repo.insert!()

%Story{
  id: 6,
  difficulty: "medium",
  content: "In a cozy kitchen, Emma and her grandmother embarked on a delightful adventure of baking bread. The scent of yeast filled the air as they measured flour, mixed ingredients, and kneaded the dough with love. Emma giggled as flour dusted her nose, and her grandmother shared stories passed down through generations. The dough rose, filling the room with anticipation. As they pulled the golden loaf from the oven, the warm aroma enveloped them. Together, they savored the joy of creating something delicious from scratch, a tradition that connected them in the heart of their home."
}
|> Repo.insert!()

          %Question{
            id: 21,
            story_id: 6,
            content: "What scent filled the air in the kitchen?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 21,
                      content: "Fresh flowers",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 21,
                      content: "Yeast",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 21,
                      content: "Coffee",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 21,
                      content: "Mint",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 22,
            story_id: 6,
            content: "What is the name of the girl in the story?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 22,
                      content: "Jane",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 22,
                      content: "Skyler",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 22,
                      content: "Emma",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 22,
                      content: "Amelia",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 23,
            story_id: 6,
            content: "Which room does this story take place?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 23,
                      content: "Kitchen",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 23,
                      content: "Basement",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 23,
                      content: "Living room",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 23,
                      content: "Attic",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 24,
            story_id: 6,
            content: "What did Emma and her grandma talk about?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 24,
                      content: "The weather",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 24,
                      content: "Sports",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 24,
                      content: "Old stories",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 24,
                      content: "Baking bread",
                      is_correct: false
                    }
                    |> Repo.insert!()

## `hard` stories
%Story{
  id: 7,
  difficulty: "hard",
  content: "In the remote observatory, Dr. Rodriguez spent countless nights studying meteors. Armed with high-powered telescopes, Dr. Rodriguez observed the celestial dance of meteors streaking across the night sky. The scientist meticulously recorded data, noting the size, composition, and trajectory of each meteor. One fateful night, a rare meteor shower illuminated the heavens. Dr. Rodriguez marveled at the spectacular display, capturing the celestial event in meticulous detail. The findings expanded our understanding of these cosmic wonders, uncovering secrets hidden in the vastness of space."
}
|> Repo.insert!()

          %Question{
            id: 25,
            story_id: 7,
            content: "Where did Dr. Rodriguez study meteors?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 25,
                      content: "On a tropical island",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 25,
                      content: "In the desert",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 25,
                      content: "In a submarine",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 25,
                      content: "In the remote observatory",
                      is_correct: true
                    }
                    |> Repo.insert!()

          %Question{
            id: 26,
            story_id: 7,
            content: "What did Dr. Rodriguez write record studying meteors?"
          }
          |> Repo.insert!()

                  %Answer{
                    question_id: 26,
                    content: "The temperature",
                    is_correct: false
                  }
                  |> Repo.insert!()

                  %Answer{
                    question_id: 26,
                    content: "The time of day",
                    is_correct: false
                  }
                  |> Repo.insert!()

                  %Answer{
                    question_id: 26,
                    content: "Details about meteors",
                    is_correct: true
                  }
                  |> Repo.insert!()

                  %Answer{
                    question_id: 26,
                    content: "The number of stars in the sky",
                    is_correct: false
                  }
                  |> Repo.insert!()

          %Question{
            id: 27,
            story_id: 7,
            content: "What illuminated the heavens during a meteor shower observed by Dr. Rodriguez?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 27,
                      content: "A solar eclipse",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 27,
                      content: "City lights",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 27,
                      content: "A passing comet",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 27,
                      content: "A meteor shower",
                      is_correct: true
                    }
                    |> Repo.insert!()

          %Question{
            id: 28,
            story_id: 7,
            content: "Who is the protagonist?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 28,
                      content: "Dr. Brown",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 28,
                      content: "Ms. Patel",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 28,
                      content: "Dr. Rodriguez",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 28,
                      content: "Mr. Smith",
                      is_correct: false
                    }
                    |> Repo.insert!()

%Story{
  id: 8,
  difficulty: "hard",
  content: "Prince was a famous singer. He was born in Minnesota in 1958. He left a lasting impact on funk, R&B, and rock, winning many awards throughout his career. Prince was also a vegetarian for much of his life. He had a prolific career, recording over 40 studio albums. On top of critical praise, Prince was loved by the general public."
}
|> Repo.insert!()

          %Question{
            id: 29,
            story_id: 8,
            content: "What singer is this excerpt about?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 29,
                      content: "Elvis",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 29,
                      content: "Prince",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 29,
                      content: "Beyonce",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 29,
                      content: "Jay-Z",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 30,
            story_id: 8,
            content: "Which of the following genres did Prince influence?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 30,
                      content: "Heavy metal",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 30,
                      content: "Funk",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 30,
                      content: "Classical",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 30,
                      content: "Folk",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 31,
            story_id: 8,
            content: "How many albums did he record?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 31,
                      content: "19",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 31,
                      content: "20",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 31,
                      content: "40",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 31,
                      content: "105",
                      is_correct: false
                    }
                    |> Repo.insert!()

          %Question{
            id: 32,
            story_id: 8,
            content: "Where was Prince born?"
          }
          |> Repo.insert!()

                    %Answer{
                      question_id: 32,
                      content: "Minnesota",
                      is_correct: true
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 32,
                      content: "Iowa",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 31,
                      content: "Michigan",
                      is_correct: false
                    }
                    |> Repo.insert!()

                    %Answer{
                      question_id: 31,
                      content: "Idaho",
                      is_correct: false
                    }
                    |> Repo.insert!()
